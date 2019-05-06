//
//  ZipError.swift
//  WeatherZip
//
//  Created by Patrick Dunshee on 5/5/19.
//  Copyright © 2019 Patrick Dunshee. All rights reserved.
//

import Foundation

enum ZipError: Error {
    
    case urlCreation
    case dataRetrievedEmpty
}

extension ZipError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .urlCreation:
            return "Failed to create URL"
        case .dataRetrievedEmpty:
            return "Retrieved data was empty"
        }
    }
}
