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
    var conversionAmount: Double!
    var displayLink: CADisplayLink?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var conversionAmountLabel: UILabel!
    @IBOutlet weak var convertedCurrencyLabel: UILabel!
    
    override func viewDidLoad() {
        // Setup UI
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
                self.activityIndicator.stopAnimating()
                self.conversionAmount = priceConversion.price
                self.animateCountingConversionPrice()
            case .failure(let error):
                self.showError(errorMessage: error.errorDescription!)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            
        // Setup View Controller
        case SegueConstants.PopupErrorEmbedSegue:
            popupErrorViewController = segue.destination as? PopupErrorViewController
            popupErrorViewController.popupErrorDelegate = self
            
        default:
            return
        }
    }
    
    func showError(errorMessage: String) {
        activityIndicator.stopAnimating()
        popupErrorViewController.errorLabel.text = errorMessage
        popupErrorViewController.view.isHidden = false
    }
    
    func showLoadingIndicator() {
        activityIndicator.startAnimating()
        conversionAmountLabel.text = ""
    }
    
    func animateCountingConversionPrice() {
        displayLink = CADisplayLink(target: self, selector: #selector(updateLabel))
        displayLink!.add(to: .main, forMode: .default)
    }
    
    func animateConversionPriceZoom() {
        // Make text bigger and green
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {
            self.conversionAmountLabel.textColor = UIColor(red: 33.0/255.0, green: 108.0/255.0, blue: 42.0/255.0, alpha: 1.0)
            self.conversionAmountLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) { (_) in
            
            // Make text smaller again and white
            UIView.animate(withDuration: 1.0, animations: {
                self.conversionAmountLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: { (_) in
                self.conversionAmountLabel.textColor = .white
            })
        }
    }
    
    // Animates label to count up very fast until it is at the conversion price
    @objc func updateLabel() {
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        let animationDuration = 1.5
        
        if elapsedTime > animationDuration {
            // Finished counting. Animate price zoom animation.
            conversionAmountLabel.text = "\(conversionAmount!)"
            displayLink?.invalidate()
            animateConversionPriceZoom()
        } else {
            let percentage = elapsedTime / animationDuration
            let value = 0.0 + percentage * (conversionAmount - 0.0)
            let divisor = pow(10.0, Double(2))
            let amount = (value * divisor).rounded() / divisor
            conversionAmountLabel.text = "\(amount)"
        }
    }
}

extension ConversionResultViewController: PopupErrorDelegate {
    func dismissError() {
        popupErrorViewController.view.isHidden = true
        navigationController?.popViewController(animated: true)
    }
}
