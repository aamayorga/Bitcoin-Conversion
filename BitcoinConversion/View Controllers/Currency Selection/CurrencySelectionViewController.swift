//
//  CurrencySelectionViewController.swift
//  BitcoinConversion
//
//  Created by Antonio Mayorga on 5/2/19.
//  Copyright © 2019 Rays Industrial Computers. All rights reserved.
//

import UIKit

class CurrencySelectionViewController: UIViewController {
    
    var enterNameChildViewController: EnterNameViewController!
    var currencySelectionTableViewController: CurrencySelectionTableViewController!
    var selectedCurrencySymbol: String!
    
    @IBOutlet weak var enterNameVCLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var enterNameVCTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var helloNameLabel: UILabel!
    
    let defaults = UserDefaults.standard
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "Enter Name Embed Segue":
            enterNameChildViewController = segue.destination as? EnterNameViewController
            enterNameChildViewController.nameEnteredDelegate = self
        case "Currency Selection Table View Embed Segue":
            currencySelectionTableViewController = segue.destination as? CurrencySelectionTableViewController
            currencySelectionTableViewController.currencySelectionDelegate = self
        case "Currency Selected Show Segue":
            let conversionViewController = segue.destination as! ConversionResultViewController
            conversionViewController.convertedCurrency = selectedCurrencySymbol
            conversionViewController.getConversionPrice(forCurrency: selectedCurrencySymbol)
        default:
            return
        }
    }
}

extension CurrencySelectionViewController: EnterNameDelegate {
    func didEnterName(name: String) {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
            self.enterNameVCTrailingConstraint.constant -= self.view.bounds.width
            self.enterNameVCLeadingConstraint.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        }) { (_) in
            let name = self.defaults.object(forKey: "Name") as! String
            self.helloNameLabel.text = "Hello, \(name)!"
        }
    }
}

extension CurrencySelectionViewController: CurrencySelectionDelegate {
    func didSelectCurrency(currencySymbol: String) {
        selectedCurrencySymbol = currencySymbol
        performSegue(withIdentifier: "Currency Selected Show Segue", sender: self)
    }
}
