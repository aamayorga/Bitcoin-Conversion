//
//  NameTextFieldDelegate.swift
//  BitcoinConversion
//
//  Created by Antonio Mayorga on 5/2/19.
//  Copyright © 2019 Rays Industrial Computers. All rights reserved.
//

import Foundation
import UIKit

class NameTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
