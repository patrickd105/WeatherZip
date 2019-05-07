//
//  ZipInfoCell.swift
//  WeatherZip
//
//  Created by Patrick Dunshee on 5/5/19.
//  Copyright © 2019 Patrick Dunshee. All rights reserved.
//

import UIKit

class ZipInfoCell: UITableViewCell {
    
    @IBOutlet weak var zipLabel: UILabel!
    
    func configureWithInfo(zipInfo: String) {
        zipLabel.text = zipInfo
    }
}
