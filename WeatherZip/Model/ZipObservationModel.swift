//
//  ZipObservationModel.swift
//  WeatherZip
//
//  Created by Patrick Dunshee on 5/5/19.
//  Copyright © 2019 Patrick Dunshee. All rights reserved.
//

import Foundation

struct ZipObservationModel: Decodable {
    
    let observations: ZipObservations
    
    struct ZipObservations: Decodable {
        
        let location: [ObservationLocation]
    }
    
    struct ObservationLocation: Decodable {
        
        let observation: [Observation]
    }
    
    struct Observation: Decodable {
        
        let city: String
        let description: String
        let iconLink: String
        let state: String
        let temperature: String
    }
}
