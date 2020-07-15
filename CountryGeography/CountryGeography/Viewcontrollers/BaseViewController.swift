//
//  BaseViewController.swift
//  CountryGeography
//
//  Created by Dona Thomas on 15/07/20.
//  Copyright © 2020 Dona Thomas. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var activityIndicatorView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addActivityIndicatorControlComponent()
    }

    // MARK: Add ActivityIndicator view
    func addActivityIndicatorControlComponent() {
        activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.center = self.view.center
        self.view.addSubview(activityIndicatorView)
    }
    // MARK: Show AlertBox
    class func showAlert(title: String, msg: String) -> UIAlertController {
        let alertView = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: NSLocalizedString("Ok", comment: ""),
                                   style: .default, handler: { _ in
        })
        alertView.addAction(action)
        return alertView
    }

}
