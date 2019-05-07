//
//  ZipManager.swift
//  WeatherZip
//
//  Created by Patrick Dunshee on 5/5/19.
//  Copyright © 2019 Patrick Dunshee. All rights reserved.
//

import Foundation

class ZipManager {
    
    let zipService: ZipService
    
    init(zipService: ZipService) {
        self.zipService = zipService
    }
    
    func fetchWeatherInfo(zipCode: String, completion: ZipServiceCompletion?) {
        zipService.fetchWeatherInfo(zipCode: zipCode, completion: completion)
    }
}
