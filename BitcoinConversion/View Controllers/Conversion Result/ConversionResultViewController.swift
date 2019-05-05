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
        let popErrorView = popupErrorViewController.view as? PopupErrorView
        popErrorView?.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showLoadingIndicator()
        convertedCurrencyLabel.text = "in \(convertedCurrency ?? "")"
    }
    
    func getConversionPrice(forCurrency currency: String) {
        BAClient().getPriceConversion(from: "BTC", to: currency, amount: 1.0) { (result) in
            switch result {
            case .success(let priceConversion):
                print(priceConversion)
            case .failure(let error):
                self.showError(errorMessage: error.errorDescription!)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            
        case SegueConstants.PopupErrorEmbedSegue:
            popupErrorViewController = segue.destination as? PopupErrorViewController
            popupErrorViewController.popupErrorDelegate = self
            
        default:
            return
        }
    }
    
    func showError(errorMessage: String) {
        popupErrorViewController.errorLabel.text = errorMessage
        popupErrorViewController.view.isHidden = false
    }
    
    func showLoadingIndicator() {
        activityIndicator.startAnimating()
        conversionAmountLabel.text = ""
    }
}

extension ConversionResultViewController: PopupErrorDelegate {
    func dismissError() {
        popupErrorViewController.view.isHidden = true
        navigationController?.popViewController(animated: true)
    }
}
