//
//  PopupErrorViewController.swift
//  BitcoinConversion
//
//  Created by Antonio Mayorga on 5/4/19.
//  Copyright © 2019 Rays Industrial Computers. All rights reserved.
//

import UIKit

protocol PopupErrorDelegate {
    func dismissError()
}

class PopupErrorViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    
    var popupErrorDelegate: PopupErrorDelegate!
    
    @IBAction func dismissError(_ sender: UIButton) {
        popupErrorDelegate.dismissError()
    }
}
