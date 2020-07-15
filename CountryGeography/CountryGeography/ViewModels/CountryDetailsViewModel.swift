//
//  CountryDetailsRestServiceManager.swift
//  CountryGeography
//
//  Created by Dona Thomas on 15/07/20.
//  Copyright © 2020 Dona Thomas. All rights reserved.
//

import Foundation

protocol ViewModelDelegate: class {
    func willLoadData()
    func didLoadData()
}

protocol ViewModelType {
    func getCountryDetails()
    var delegate: ViewModelDelegate? { get set }
}

protocol CountryDetailsViewModelType: ViewModelType {
    var countryDetailsObj: CountryDetailsListModel? { get }
}

class CountryDetailsViewModel: CountryDetailsViewModelType {

    var countryDetailsObj: CountryDetailsListModel?
    weak var delegate: ViewModelDelegate?
    let dataSource: CountryDetailsDataSource

    init(dataSource: CountryDetailsDataSource) {
        self.dataSource = dataSource
    }

    func getCountryDetails() {
        loadData()
    }

    private func loadData() {
        delegate?.willLoadData()
        dataSource.fetchCountryInfo { [weak self] result in
            DispatchQueue.main.async {
                guard let info = self else { return }
                switch result {
                case .failure:
                    info.countryDetailsObj = nil
                case .success(let countryDetails):
                    info.countryDetailsObj = countryDetails
                }
                info.delegate?.didLoadData()
            }
        }
    }
}
