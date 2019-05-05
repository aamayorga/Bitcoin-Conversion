//
//  ConversionViewController.swift
//  BitcoinConversion
//
//  Created by Antonio Mayorga on 5/3/19.
//  Copyright © 2019 Rays Industrial Computers. All rights reserved.
//

import UIKit

class ConversionResultViewController: UIViewController {
    
    let animationStartDate = Date()
    
    var popupErrorViewController: PopupErrorViewController!
    var convertedCurrency: String!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var conversionAmountLabel: UILabel!
    @IBOutlet weak var convertedCurrencyLabel: UILabel!
    
    override func viewDidLoad() {
        let conversionResultView = self.view as? ConversionResultView
        conversionResultView?.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        convertedCurrencyLabel.text = "in \(convertedCurrency ?? "")"
    }
    
    func getConversionPrice(forCurrency currency: String) {
        BAClient().getPriceConversion(from: "BTC", to: currency, amount: 1.0) { (result) in
            switch result {
            case .success(let priceConversion):
                print(priceConversion)
            case .failure(let error):
                print(error)
            }
        }
    }
}
