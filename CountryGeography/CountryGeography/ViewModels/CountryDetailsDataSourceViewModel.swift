//
//  CountryDetailsDataSourceViewModel.swift
//  CountryGeography
//
//  Created by Dona Thomas on 15/07/20.
//  Copyright © 2020 Dona Thomas. All rights reserved.
//

import Foundation

protocol CountryDetailDataSourceType {
    func fetchCountryInfo(completion: @escaping (_ result: Result<CountryDetailsListModel>) -> Void)
}

class CountryDetailsDataSource: CountryDetailDataSourceType {

    func fetchCountryInfo(completion: @escaping (_ result: Result<CountryDetailsListModel>) -> Void) {
        let countryDetailsRestServiceManager = CountryDetailsRestServiceManager()
        countryDetailsRestServiceManager.getCountryInfo(completion: { result in
            completion(result as Result<CountryDetailsListModel>)
        })
    }

}
