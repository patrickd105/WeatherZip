//
//  UIView+Helper.swift
//  WeatherZip
//
//  Created by Patrick Dunshee on 5/6/19.
//  Copyright © 2019 Patrick Dunshee. All rights reserved.
//

import UIKit

extension UIView {
    
    class func nibInstance<T: UIView>() -> T {
        guard let selfType = self as? T.Type, let contentView = Bundle.main.loadNibNamed(String(describing: selfType), owner: nil, options: nil)?.first as? T else {
            fatalError("Check the NIB name")
        }
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }
}
