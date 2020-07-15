//
//  CountryDetailsRestServiceManager.swift
//  CountryGeography
//
//  Created by Dona Thomas on 15/07/20.
//  Copyright © 2020 Dona Thomas. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}
// MARK: CountryInfoRestService
// ===================

class CountryDetailsRestServiceManager {
    private let countryInfoBaseURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    init() {
    }
    func getCountryInfo(completion: @escaping (_ result: Result<CountryDetailsListModel>) -> Void) {
        let countryInfoFetchURL = NSURL(string: self.countryInfoBaseURL)!
        getCountryDataFromServer(countryRequestURL: countryInfoFetchURL) { result in
            completion(result as Result<CountryDetailsListModel>)
        }
    }
    private func getCountryDataFromServer(countryRequestURL: NSURL,
                                          completion: @escaping (Result<CountryDetailsListModel>) -> Void) {
        // This is a pretty simple networking task, so the shared session will do.
        let session = URLSession.shared
        session.configuration.timeoutIntervalForRequest = 3
        // The data task retrieves the data.
        let dataTask =
            session.dataTask(with: countryRequestURL as URL) { (data: Data?, _: URLResponse?, error: Error?) in
            if error != nil {
                // Case 1: Error
                // An error occurred while trying to get data from the server.

                completion(.failure(error!))
            } else {
                // Case 2: Success
                // We got data from the server!
                do {
                    // Try to convert that data into a Swift dictionary

                    if let data = data {
                        //Jsonstring contains an alphabet "É" in third last object which is unable to parse.
                        // So encoding is needed
                        if let jsonString = String(data: data, encoding: .isoLatin1) {
                            //print(jsonString)
                            let countryData = try JSONSerialization.jsonObject(
                                with: Data(jsonString.utf8),
                                options: .mutableContainers) as? [String: Any?]
                            // If we made it to this point, we've successfully converted the
                            // JSON-formatted data into a Swift dictionary.
                            let countryInfoDetails = CountryDetailsListModel(countryInfo: countryData ?? [:])
                            let result: Result<CountryDetailsListModel> = Result.success(countryInfoDetails)
                            completion(result)
                        } else {
                            completion(.failure(error!))
                        }
                    } else {
                         completion(.failure(error!))
                    }
                } catch let jsonError as NSError {
                    // An error occurred while trying to convert the data into a Swift dictionary.
                    completion(.failure(jsonError))
                }
            }
        }
        // The data task is set up...launch it!
        dataTask.resume()
    }
}
