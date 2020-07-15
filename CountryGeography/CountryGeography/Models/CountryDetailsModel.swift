//
//  CountryDetails.swift
//  CountryGeography
//
//  Created by Dona Thomas on 15/07/20.
//  Copyright © 2020 Dona Thomas. All rights reserved.
//

import Foundation

struct CountryDetailsModel {
    let title: String?
    let description: String?
    let imageRef: String?
    init(title: String?, description: String?, imageRef: String?) {
        self.title = title
        self.description = description
        self.imageRef = imageRef
    }
}
