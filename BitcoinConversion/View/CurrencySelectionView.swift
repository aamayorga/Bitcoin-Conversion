//
//  CurrencySelectionView.swift
//  BitcoinConversion
//
//  Created by Antonio Mayorga on 5/4/19.
//  Copyright © 2019 Rays Industrial Computers. All rights reserved.
//

import UIKit

class CurrencySelectionView: UIView {
    @IBOutlet weak var helloNameLabel: UILabel!
    @IBOutlet weak var pickCurrencyLabel: UILabel!
    @IBOutlet weak var enterNameContainerView: UIView!
    
    func setupViews() {
        setupMainView()
        setupHelloLabel()
        setupPickCurrencyLabel()
    }
    
    func setupMainView() {
        let firstColor          = UIColor(red: 247.0 / 255.0, green: 147.0 / 255.0, blue: 26.0 / 255.0, alpha: 1.0)
        let secondColor         = UIColor(red: 224.0 / 255.0, green: 99.0 / 255.0, blue: 13.0 / 255.0, alpha: 1.0)
        
        let gradientLayer         = CAGradientLayer()
        gradientLayer.frame       = bounds
        gradientLayer.colors      = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.locations   = [0.0, 1.0]
        gradientLayer.startPoint  = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint    = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setupHelloLabel() {
        helloNameLabel.textAlignment    = .center
        helloNameLabel.textColor        = .white
        helloNameLabel.numberOfLines     = 0
        helloNameLabel.font             = UIFont.boldSystemFont(ofSize: 42.0)
    }
    
    func setupPickCurrencyLabel() {
        pickCurrencyLabel.textAlignment = .center
        pickCurrencyLabel.textColor     = .white
        pickCurrencyLabel.font          = UIFont.systemFont(ofSize: 24.0, weight: .light)
    }
}
