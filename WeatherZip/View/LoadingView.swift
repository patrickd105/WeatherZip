//
//  LoadingView.swift
//  WeatherZip
//
//  Created by Patrick Dunshee on 5/6/19.
//  Copyright © 2019 Patrick Dunshee. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    @IBOutlet weak var indicatorContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    func configureView() {
        indicatorContainerView.layer.cornerRadius = 10
        indicatorContainerView.layer.masksToBounds = true
    }
    
    func presentOverAll() {
        if let wrappedWindow = UIApplication.shared.delegate?.window, let window = wrappedWindow {
            presentInView(window)
        }
    }
    
    func presentInView(_ view: UIView) {
        dismiss()
        view.addSubview(self)
        
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func dismiss() {
        removeFromSuperview()
    }
}
