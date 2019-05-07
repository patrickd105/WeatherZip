//
//  ZipViewData.swift
//  WeatherZip
//
//  Created by Patrick Dunshee on 5/5/19.
//  Copyright © 2019 Patrick Dunshee. All rights reserved.
//

import Foundation

class ZipViewData {
    
    let city: String
    let weatherDescription: String
    let iconURL: String
    let state: String
    let temperature: String
    
    init(city: String, weatherDescription: String, iconURL: String, state: String, temperature: String) {
        self.city = city
        self.weatherDescription = weatherDescription
        self.iconURL = iconURL
        self.state = state
        self.temperature = temperature
    }
}
