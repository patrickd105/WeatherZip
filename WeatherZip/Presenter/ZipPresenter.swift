//
//  ZipPresenter.swift
//  WeatherZip
//
//  Created by Patrick Dunshee on 5/5/19.
//  Copyright © 2019 Patrick Dunshee. All rights reserved.
//

import Foundation

protocol ZipView: class {
    
    func setZipData(zipData: ZipViewData)
    func presentFailureAlert(title: String, message: String)
    func showLoading()
    func dismissLoading()
}

enum ZipRowMap {
    
    case city
    case state
    case currentTemperature
    case weatherDescription
}

class ZipPresenter {
    
    weak var zipView: ZipView?
    var zipManager: ZipManager
    var rowMap = [ZipRowMap]()
    
    init(zipService: ZipService) {
        zipManager = ZipManager(zipService: zipService)
    }
    
    func attachView(zipView: ZipView) {
        self.zipView = zipView
    }
    
    func detachView() {
        zipView = nil
    }
    
    func loadZipData(zipCode: String) {
        zipView?.showLoading()
        zipManager.fetchWeatherInfo(zipCode: zipCode) { [weak self] result in
            DispatchQueue.main.async {
                self?.zipView?.dismissLoading()
                switch result {
                case .success(let zipObservationModel):
                    if let zipObservation = zipObservationModel.observations.location.first?.observation.first {
                        let zipViewData = ZipViewData(city: zipObservation.city, weatherDescription: zipObservation.description, iconURL: zipObservation.iconLink, state: zipObservation.state, temperature: zipObservation.temperature)
                        self?.zipView?.setZipData(zipData: zipViewData)
                    } else {
                        self?.zipView?.presentFailureAlert(title: NSLocalizedString("Error Retrieving Weather Data", comment: "alert title"), message: ZipError.dataRetrievedEmpty.localizedDescription)
                    }
                case .failure(let error):
                    self?.zipView?.presentFailureAlert(title: NSLocalizedString("Error Retrieving Weather Data", comment: "alert title"), message: error.localizedDescription)
                }
            }
        }
    }
    
    func loadRowMap(zipViewData: ZipViewData?) {
        if zipViewData != nil {
            rowMap = [.city, .state, .weatherDescription, .currentTemperature]
        } else {
            rowMap = []
        }
    }
}
