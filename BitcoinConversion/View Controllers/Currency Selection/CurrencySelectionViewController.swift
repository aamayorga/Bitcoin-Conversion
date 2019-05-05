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
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor(red: 196.0 / 118.0, green: 88.0 / 255.0, blue: 22.0 / 255.0, alpha: 1.0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        // Setup UI
        let enterNameView = enterNameChildViewController.view as? EnterNameView
        enterNameView?.setupViews()
        let currencySelectionView = self.view as? CurrencySelectionView
        currencySelectionView?.setupViews()
        
        // Check for a name and remove enter name view if there is a name
        if defaults.bool(forKey: "isNameEntered") {
            enterNameChildViewController.willMove(toParent: nil)
            enterNameChildViewController.view.removeFromSuperview()
            enterNameChildViewController.removeFromParent()
            enterNameContainerView.removeFromSuperview()
            visualEffectView.removeFromSuperview()
            
            showName()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            
        // Setup Container View Controllers and Segues
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
    
    func showName() {
        let name = self.defaults.object(forKey: "Name") as! String
        self.helloNameLabel.text = "Hello,\n\(name)!"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !defaults.bool(forKey: "isNameEntered") {
            animateView()
        }
    }
    
    func animateView() {
        self.enterNameVCCenterYConstraint.constant -= view.frame.height
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1, delay: 1, options: .curveEaseInOut, animations: {
            self.enterNameVCCenterYConstraint.constant = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc func adjustForKeyboard(_ notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            enterNameVCCenterYConstraint.constant = 0
        } else {
            enterNameVCCenterYConstraint.constant = -( (enterNameChildViewController.view.frame.height/2) - (keyboardViewEndFrame.minY - view.center.y) + 16 )
        }
    }
}

extension CurrencySelectionViewController: EnterNameDelegate {
    func didEnterName(name: String) {
        defaults.set(true, forKey: "isNameEntered")
        defaults.set(name, forKey: "Name")
        
        showName()
        
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
