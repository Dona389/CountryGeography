//
//  StringUtil.swift
//  CountryGeography
//
//  Created by Dona Thomas on 15/07/20.
//  Copyright © 2020 Dona Thomas. All rights reserved.
//

import Foundation

public enum StringUtil: String {
    case countryDetailsCellReuseIdentifier = "CountryDetailsCellReuseIdentifier"
    case networkFailureTitle = "No Internet Connection!"
    case networkFailureMsg = "Please check your Internet Connection and try again."
    case boldFont = "AvenirNext-DemiBold"
    case regularFont = "Avenir-Book"
    //UI Accessibility Identifiers
    case tableviewAccessibilityId = "countryInfoTableview"
    case cellAccessibilityId = "countryDetailsCell_%d_%d"
    case cellImageviewAccessibilityId = "profileImgView"
    case cellNameLabelAccessibilityId = "nameLabel"
    case cellDetailLabelAccessibilityId = "detailLabel"
}
