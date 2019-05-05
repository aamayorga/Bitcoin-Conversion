//
//  EnterNameViewController.swift
//  BitcoinConversion
//
//  Created by Antonio Mayorga on 5/2/19.
//  Copyright © 2019 Rays Industrial Computers. All rights reserved.
//

import UIKit

protocol EnterNameDelegate {
    func didEnterName(name: String)
}

class EnterNameViewController: UIViewController {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var enterNameTextField: UITextField!
    
    var nameEnteredDelegate: EnterNameDelegate!
    var enteredName = String()
    
    override func viewDidLoad() {
        enterNameTextField.delegate = self
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
        saveName()
    }
    
    func saveName() {
        // Check if user entered a name and not an empty string
        enteredName = enterNameTextField.text ?? ""
        guard !enteredName.isEmpty else {
            errorLabel.text = "Please enter valid name"
            return
        }
        
        enterNameTextField.resignFirstResponder()
        errorLabel.text = " "
        
        nameEnteredDelegate.didEnterName(name: enteredName)
    }
}

extension EnterNameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
