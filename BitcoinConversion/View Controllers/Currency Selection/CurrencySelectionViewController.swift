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
    
    @IBOutlet weak var enterNameVCLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var enterNameVCTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var helloNameLabel: UILabel!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Enter Name Embed Segue" {
            enterNameChildViewController = segue.destination as? EnterNameViewController
            enterNameChildViewController.nameEnteredDelegate = self
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
