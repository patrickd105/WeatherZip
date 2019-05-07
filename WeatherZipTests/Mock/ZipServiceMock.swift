//
//  ZipServiceMock.swift
//  WeatherZipTests
//
//  Created by Patrick Dunshee on 5/6/19.
//  Copyright © 2019 Patrick Dunshee. All rights reserved.
//

@testable import WeatherZip

class ZipServiceMock: ZipService {
    
    var fetchWeatherInfoResult: Result<ZipObservationModel, Error>?
    
    override func fetchWeatherInfo(zipCode: String, completion: ZipServiceCompletion?) {
        if let result = fetchWeatherInfoResult {
            completion?(result)
        }
    }
}
