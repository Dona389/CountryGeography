//
//  CountryDetailsViewController.swift
//  CountryGeography
//
//  Created by Dona Thomas on 15/07/20.
//  Copyright © 2020 Dona Thomas. All rights reserved.
//

import UIKit
import SDWebImage

class CountryDetailsViewController: BaseViewController, ViewModelDelegate {
    fileprivate let tableview = UITableView()
    fileprivate var refreshControl = UIRefreshControl()
    fileprivate let countryDetailsCellReuseIdentifier = StringUtil.countryDetailsCellReuseIdentifier.rawValue
    private var countryDetailsViewModelType: CountryDetailsViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()
        //Add UI components programatically
        addTableViewComponent()
        addActivityIndicatorControlComponent()
        //setup viewmodel connection
        countryDetailsViewModelType = CountryDetailsViewModel(dataSource: CountryDetailsDataSource())
        countryDetailsViewModelType.delegate = self
        getCountryDetailsList()
    }
    // MARK: Get data from rest service call
    //Get data from server
    func getCountryDetailsList() {
        if currentReachabilityStatus != .notReachable {
            countryDetailsViewModelType.getCountryDetails()
        } else {
            let title = StringUtil.networkFailureTitle.rawValue
            let message = StringUtil.networkFailureMsg.rawValue
            self.present(BaseViewController.showAlert(title: title, msg: message), animated: true, completion: nil)
        }
    }
    // MARK: Add UI components programatically to the view
    func addTableViewComponent() {
        tableview.isAccessibilityElement = true
        tableview.accessibilityIdentifier = StringUtil.tableviewAccessibilityId.rawValue
        tableview.dataSource = self
        tableview.delegate = self
        tableview.estimatedRowHeight = 100
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(CountryDetailsTableViewCell.self, forCellReuseIdentifier: countryDetailsCellReuseIdentifier)
        view.addSubview(tableview)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        // add refreshui control to tableview
        addRefreshTableviewComponent()
    }
    func addRefreshTableviewComponent() {
        refreshControl = {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action:
                #selector(self.handleRefresh(_:)),
                                     for: UIControl.Event.valueChanged)
            refreshControl.tintColor = UIColor.darkGray
            return refreshControl
        }()
        DispatchQueue.main.async {
            self.tableview.addSubview(self.refreshControl)
        }
    }
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        countryDetailsViewModelType.getCountryDetails()
    }
    // MARK: Implement viewmodel delegate stubs
    func willLoadData() {
        self.activityIndicatorView.startAnimating()
    }
    func didLoadData() {
        DispatchQueue.main.async {
            if self.countryDetailsViewModelType.countryDetailsObj != nil {
                self.title = self.countryDetailsViewModelType.countryDetailsObj?.countryName ?? ""
            }
            self.tableview.reloadData()
            self.activityIndicatorView.stopAnimating()
            self.refreshControl.endRefreshing()
        }
    }
}

// MARK: Implement tableview delegate and datasource methods
extension CountryDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.countryDetailsViewModelType.countryDetailsObj != nil {
            return countryDetailsViewModelType.countryDetailsObj?.countryInfoList?.count ?? 0
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: countryDetailsCellReuseIdentifier,
                                                       for: indexPath) as? CountryDetailsTableViewCell else {
            let cell = CountryDetailsTableViewCell(style: .default, reuseIdentifier: countryDetailsCellReuseIdentifier)
            cell.isAccessibilityElement = true
            cell.accessibilityIdentifier = String(format: StringUtil.cellAccessibilityId.rawValue,
                                                        indexPath.section, indexPath.row)
            return cell
        }
        cell.isAccessibilityElement = true
        cell.accessibilityIdentifier = String(format: StringUtil.cellAccessibilityId.rawValue,
                                                    indexPath.section, indexPath.row)
        if (countryDetailsViewModelType.countryDetailsObj?.countryInfoList?.count ?? 0) > 0 {
            let countryDetails = countryDetailsViewModelType.countryDetailsObj?.countryInfoList?[indexPath.row]
            cell.nameLabel.text = countryDetails?.title
            cell.detailLabel.text = countryDetails?.description
            let imageRef = countryDetailsViewModelType.countryDetailsObj?.countryInfoList?[indexPath.row].imageRef ?? ""
            cell.profileImgView.sd_setImage(with: URL(string: imageRef),
                                            placeholderImage: UIImage(named: "defaultImg.png"))
        }
        return cell
    }
}

