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
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var enterNameContainerView: UIView!
    @IBOutlet weak var enterNameVCLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var enterNameVCTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var enterNameVCCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var helloNameLabel: UILabel!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        
        if defaults.bool(forKey: "isNameEntered") {
            // Remove Enter Name View Controller
            enterNameChildViewController.willMove(toParent: nil)
            enterNameChildViewController.view.removeFromSuperview()
            enterNameChildViewController.removeFromParent()
            enterNameContainerView.removeFromSuperview()
            visualEffectView.removeFromSuperview()
            
            setupName()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            
        case SegueConstants.EnterNameEmbedSegue:
            enterNameChildViewController = segue.destination as? EnterNameViewController
            enterNameChildViewController.nameEnteredDelegate = self
            
        case SegueConstants.CurrencySelectionTableViewEmbedSegue:
            currencySelectionTableViewController = segue.destination as? CurrencySelectionTableViewController
            currencySelectionTableViewController.currencySelectionDelegate = self
            
        case SegueConstants.CurrencySelectedShowSegue:
            let conversionViewController = segue.destination as! ConversionResultViewController
            conversionViewController.convertedCurrency = selectedCurrencySymbol
            conversionViewController.getConversionPrice(forCurrency: selectedCurrencySymbol)
            
        default:
            return
        }
    }
    
    func setupName() {
        let name = self.defaults.object(forKey: "Name") as! String
        self.helloNameLabel.text = "Hello,\n\(name)!"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !defaults.bool(forKey: "isNameEntered") {
            print("We have a name")
        }
    }
    
    
}

extension CurrencySelectionViewController: EnterNameDelegate {
    func didEnterName(name: String) {
        defaults.set(true, forKey: "isNameEntered")
        defaults.set(name, forKey: "Name")
        
        setupName()
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.enterNameVCTrailingConstraint.constant -= self.view.bounds.width
            self.enterNameVCLeadingConstraint.constant += self.view.bounds.width
            self.visualEffectView.effect = nil
            self.view.layoutIfNeeded()
        }, completion: { (_) in
            self.visualEffectView.removeFromSuperview()
        })
    }
}

extension CurrencySelectionViewController: CurrencySelectionDelegate {
    func didSelectCurrency(currencySymbol: String) {
        selectedCurrencySymbol = currencySymbol
        performSegue(withIdentifier: SegueConstants.CurrencySelectedShowSegue, sender: self)
    }
}
