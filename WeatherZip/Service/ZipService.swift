//
//  ZipService.swift
//  WeatherZip
//
//  Created by Patrick Dunshee on 5/5/19.
//  Copyright © 2019 Patrick Dunshee. All rights reserved.
//

import Foundation

typealias ZipServiceCompletion = (Result<ZipObservationModel, Error>) -> Void

class ZipService {
    
    var urlSession = URLSession.shared
    var dataTask: URLSessionDataTask?
    
    func fetchWeatherInfo(zipCode: String, completion: ZipServiceCompletion?) {
        dataTask?.cancel()
        
        if var urlComponents = URLComponents(string: "https://weather.cit.api.here.com/weather/1.0/report.json") {
            urlComponents.query = "product=observation&app_id=DemoAppId01082013GAL&app_code=AJKnXv84fjrb0KIHawS0Tg&zipcode=\(zipCode)&one"
            
            guard let url = urlComponents.url else {
                completion?(.failure(ZipError.urlCreation))
                return
            }
            
            dataTask = urlSession.dataTask(with: url) { [weak self] data, response, error in
                defer { self?.dataTask = nil }
                
                if let error = error {
                    completion?(.failure(error))
                } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let model = try decoder.decode(ZipObservationModel.self, from: data)
                        completion?(.success(model))
                    } catch {
                        completion?(.failure(error))
                    }
                }
            }
            
            dataTask?.resume()
        }
    }
}
