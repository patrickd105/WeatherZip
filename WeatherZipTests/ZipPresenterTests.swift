//
//  ZipPresenterTests.swift
//  WeatherZipTests
//
//  Created by Patrick Dunshee on 5/6/19.
//  Copyright © 2019 Patrick Dunshee. All rights reserved.
//

import XCTest
@testable import WeatherZip

class ZipViewMock: ZipView {
    
    var expectation: XCTestExpectation?
    
    var setZipDataCalled = false
    var presentFailureAlertCalled = false
    var showLoadingCalled = false
    var dismissLoadingCalled = false
    
    func setZipData(zipData: ZipViewData) {
        setZipDataCalled = true
        expectation?.fulfill()
    }
    
    func presentFailureAlert(title: String, message: String) {
        presentFailureAlertCalled = true
        expectation?.fulfill()
    }
    
    func showLoading() {
        showLoadingCalled = true
    }
    
    func dismissLoading() {
        dismissLoadingCalled = true
    }
}

class ZipPresenterTests: XCTestCase {
    
    var zipPresenter: ZipPresenter!
    var zipView: ZipViewMock!
    var zipServiceMock: ZipServiceMock!
    
    override func setUp() {
        super.setUp()
        
        zipServiceMock = ZipServiceMock()
        zipPresenter = ZipPresenter(zipService: zipServiceMock)
        zipView = ZipViewMock()
        zipPresenter.attachView(zipView: zipView)
    }
    
    func testLoadZipData_Success() {
        let observation = ZipObservationModel.Observation(city: "Test", description: "Test", iconLink: "Test", state: "Test", temperature: "30")
        let observationLocation = ZipObservationModel.ObservationLocation(observation: [observation])
        let zipObservations = ZipObservationModel.ZipObservations(location: [observationLocation])
        let zipModel = ZipObservationModel(observations: zipObservations)
        zipServiceMock.fetchWeatherInfoResult = .success(zipModel)
        
        zipView.expectation = expectation(description: #function)
        
        zipPresenter.loadZipData(zipCode: "78704")
        
        waitForExpectations(timeout: 2.0, handler: nil)
        
        XCTAssertTrue(zipView.setZipDataCalled)
        XCTAssertTrue(zipView.showLoadingCalled)
        XCTAssertTrue(zipView.dismissLoadingCalled)
    }
    
    func testLoadZipData_Failure_NoObservationLocations() {
        let zipObservations = ZipObservationModel.ZipObservations(location: [])
        let zipModel = ZipObservationModel(observations: zipObservations)
        zipServiceMock.fetchWeatherInfoResult = .success(zipModel)
        
        zipView.expectation = expectation(description: #function)
        
        zipPresenter.loadZipData(zipCode: "78704")
        
        waitForExpectations(timeout: 2.0, handler: nil)
        
        XCTAssertTrue(zipView.presentFailureAlertCalled)
        XCTAssertTrue(zipView.showLoadingCalled)
        XCTAssertTrue(zipView.dismissLoadingCalled)
    }
    
    func testLoadZipData_Failure_NetworkFailure() {
        zipServiceMock.fetchWeatherInfoResult = .failure(ZipError.dataRetrievedEmpty)
        
        zipView.expectation = expectation(description: #function)
        
        zipPresenter.loadZipData(zipCode: "78704")
        
        waitForExpectations(timeout: 2.0, handler: nil)
        
        XCTAssertTrue(zipView.presentFailureAlertCalled)
        XCTAssertTrue(zipView.showLoadingCalled)
        XCTAssertTrue(zipView.dismissLoadingCalled)
    }
    
    func testLoadRowMap_Empty() {
        zipPresenter.loadRowMap(zipViewData: nil)
        
        XCTAssertEqual(zipPresenter.rowMap.count, 0)
    }
    
    func testLoadRowMap_WithData() {
        zipPresenter.loadRowMap(zipViewData: ZipViewData(city: "a", weatherDescription: "b", iconURL: "c", state: "d", temperature: "e"))
        
        XCTAssertEqual(zipPresenter.rowMap.count, 4)
    }
}
