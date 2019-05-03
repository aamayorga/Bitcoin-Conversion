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
    
    let defaults = UserDefaults.standard
    
    var nameTextFieldDelegate = NameTextFieldDelegate()
    var nameEnteredDelegate: EnterNameDelegate!
    var enteredName = String()
    
    override func viewDidLoad() {
        enterNameTextField.delegate = nameTextFieldDelegate
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

        defaults.set(enteredName, forKey: "Name")
        nameEnteredDelegate.didEnterName(name: enteredName)
    }
    
    func dismissEnterNameViewController() {
        enterNameTextField.resignFirstResponder()
        errorLabel.text = ""
        defaults.set(false, forKey: "firstTimeSetup")
    }
}
