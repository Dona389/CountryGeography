//
//  CountryGeographyTests.swift
//  CountryGeographyTests
//
//  Created by Dona Thomas on 15/07/20.
//  Copyright © 2020 Dona Thomas. All rights reserved.
//

import XCTest
@testable import CountryGeography

class CountryGeographyTests: XCTestCase, ViewModelDelegate {
    private var countryDetailsRestServiceManager: CountryDetailsRestServiceManager!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        countryDetailsRestServiceManager = CountryDetailsRestServiceManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testGetCountryInfo() {
        // 1. Create expectation
        let expectation = self.expectation(description: "Getting country details from server")
        countryDetailsRestServiceManager.getCountryInfo(completion: { _ in
            // 2. Signal
            expectation.fulfill()
        })

        // 4. Assert
            waitForExpectations(timeout: 5) { error in
             if let error = error {
                 XCTFail("waitForExpectationsWithTimeout error: \(error)")
             }
         }
    }
    func testFetchData() {
        let countryDetailsViewModelType = CountryDetailsViewModel(dataSource: CountryDetailsDataSource())
        countryDetailsViewModelType.getCountryDetails()
    }
    func willLoadData() {
    }
    func didLoadData() {
    }

}

