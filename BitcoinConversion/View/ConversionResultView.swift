//
//  ConversionResultView.swift
//  BitcoinConversion
//
//  Created by Antonio Mayorga on 5/5/19.
//  Copyright © 2019 Rays Industrial Computers. All rights reserved.
//

import UIKit

class ConversionResultView: UIView {

    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var convertedAmountLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    func setupViews() {
        setupMainView()
        setupBitcoinLabel()
        setupConvertedAmountLabel()
        setupCurrencyLabel()
    }
    
    func setupMainView() {
        let firstColor  = UIColor(red: 247.0 / 255.0, green: 148.0 / 255.0, blue: 27.0 / 255.0, alpha: 1.0)
        let secondColor = UIColor(red: 252.0 / 255.0, green: 195.0 / 255.0, blue: 15.0 / 255.0, alpha: 1.0)
        
        let gradientLayer            = CAGradientLayer()
        gradientLayer.frame          = bounds
        gradientLayer.colors         = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.locations      = [0.0, 1.0]
        gradientLayer.startPoint     = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint       = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setupBitcoinLabel() {
        bitcoinLabel.textAlignment  = .center
        bitcoinLabel.textColor      = .white
        bitcoinLabel.font           = UIFont.systemFont(ofSize: 24.0, weight: .regular)
    }
    
    func setupConvertedAmountLabel() {
        convertedAmountLabel.textAlignment  = .center
        convertedAmountLabel.textColor      = .white
        convertedAmountLabel.font           = UIFont.systemFont(ofSize: 48.0, weight: .bold)
    }
    
    func setupCurrencyLabel() {
        currencyLabel.textAlignment     = .center
        currencyLabel.textColor         = .white
        currencyLabel.font              = UIFont.systemFont(ofSize: 24.0, weight: .regular)
    }

}
