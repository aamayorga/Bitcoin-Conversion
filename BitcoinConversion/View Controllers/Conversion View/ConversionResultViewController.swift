//
//  ConversionViewController.swift
//  BitcoinConversion
//
//  Created by Antonio Mayorga on 5/3/19.
//  Copyright © 2019 Rays Industrial Computers. All rights reserved.
//

import UIKit

class ConversionResultViewController: UIViewController {
    
    var convertedCurrency: String!
    
    @IBOutlet weak var conversionAmountLabel: UILabel!
    @IBOutlet weak var convertedCurrencyLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        convertedCurrencyLabel.text = "in \(convertedCurrency ?? "")"
    }
    
    func getConversionPrice(forCurrency currency: String) {
        BAClient().getPriceConversion(from: "BTC", to: currency, amount: 1.0) { (result) in
            switch result {
            case .success(let priceConversion):
                self.conversionAmountLabel.text = "\(priceConversion.price)"
            case .failure(let error):
                print(error)
            }
        }
    }
}
