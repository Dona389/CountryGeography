//
//  CountryDetailsListModel.swift
//  CountryGeography
//
//  Created by Dona Thomas on 15/07/20.
//  Copyright © 2020 Dona Thomas. All rights reserved.
//

import Foundation

struct CountryDetailsListModel {
    var countryName: String? = ""
    var countryInfoList: [CountryDetailsModel]? = []

    init() {
    }
    init(countryInfo: [String: Any?]?) {
        countryName = countryInfo?["title"] as? String
        let infoDict = countryInfo?["rows"] as? [[String: AnyObject]] ?? []
        for countryDetails in infoDict {
            let detailsTitle =  countryDetails["title"] as? String
            let detailsDesc = countryDetails["description"] as? String
            let detailsImgRef = countryDetails["imageHref"] as? String
            if detailsTitle != nil || detailsDesc != nil || detailsImgRef != nil {
                let countryInfoDetails = CountryDetailsModel(title: detailsTitle,
                    description: detailsDesc, imageRef: detailsImgRef)
                self.countryInfoList?.append(countryInfoDetails)
            }
        }
    }
}
