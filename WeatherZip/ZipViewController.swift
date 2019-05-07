//
//  ZipViewController.swift
//  WeatherZip
//
//  Created by Patrick Dunshee on 5/5/19.
//  Copyright © 2019 Patrick Dunshee. All rights reserved.
//

import Kingfisher
import UIKit

class ZipViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var zipViewData: ZipViewData?
    var zipPresenter: ZipPresenter!
    let zipCode = "78704"
    var loadingView: LoadingView! = LoadingView.nibInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    func configureView() {
        title = zipCode
        
        let zipService = ZipService()
        zipPresenter = ZipPresenter(zipService: zipService)
        
        tableView.register(UINib(nibName: String(describing: ZipInfoCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ZipInfoCell.self))
        tableView.tableFooterView = UIView()
        
        zipPresenter.attachView(zipView: self)
        zipPresenter.loadZipData(zipCode: zipCode)
    }
}

// MARK: - UITableViewDataSource

extension ZipViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return zipPresenter.rowMap.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        guard let zipViewData = zipViewData else {
            return cell
        }
        let row = zipPresenter.rowMap[indexPath.row]
        switch row {
        case .city:
            if let zipInfoCell = tableView.dequeueReusableCell(withIdentifier: String(describing: ZipInfoCell.self), for: indexPath) as? ZipInfoCell {
                zipInfoCell.configureWithInfo(zipInfo: "City: \(zipViewData.city)")
                cell = zipInfoCell
            }
        case .state:
            if let zipInfoCell = tableView.dequeueReusableCell(withIdentifier: String(describing: ZipInfoCell.self), for: indexPath) as? ZipInfoCell {
                zipInfoCell.configureWithInfo(zipInfo: "State: \(zipViewData.state)")
                cell = zipInfoCell
            }
        case .weatherDescription:
            if let zipInfoCell = tableView.dequeueReusableCell(withIdentifier: String(describing: ZipInfoCell.self), for: indexPath) as? ZipInfoCell {
                zipInfoCell.configureWithInfo(zipInfo: "\(zipViewData.weatherDescription)")
                cell = zipInfoCell
            }
        case .currentTemperature:
            if let zipInfoCell = tableView.dequeueReusableCell(withIdentifier: String(describing: ZipInfoCell.self), for: indexPath) as? ZipInfoCell {
                zipInfoCell.configureWithInfo(zipInfo: "Current Temperature: \(zipViewData.temperature) °C")
                cell = zipInfoCell
            }
        }
        return cell
    }
}

// MARK: - ZipView

extension ZipViewController: ZipView {
    
    func showLoading() {
        loadingView.presentOverAll()
    }
    
    func dismissLoading() {
        loadingView.dismiss()
    }
    
    func setZipData(zipData: ZipViewData) {
        self.zipViewData = zipData
        zipPresenter.loadRowMap(zipViewData: self.zipViewData)
        if let iconURL = URL(string: zipData.iconURL) {
            backgroundImageView.kf.setImage(with: iconURL)
        }
        tableView.reloadData()
    }
    
    func presentFailureAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: "alert action"), style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
