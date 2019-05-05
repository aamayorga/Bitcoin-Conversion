//
//  EnterNameView.swift
//  BitcoinConversion
//
//  Created by Antonio Mayorga on 5/4/19.
//  Copyright © 2019 Rays Industrial Computers. All rights reserved.
//

import UIKit

class EnterNameView: UIView {

    @IBOutlet var enterNameLabel: UILabel!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var enterNameTextField: UITextField!
    @IBOutlet var doneButton: UIButton!
    
    func setupViews() {
        setupMainView()
        setupNameLabel()
        setupErrorLabel()
        setupNameTextField()
        setupDoneButton()
    }

    func setupMainView() {
        layer.cornerRadius  = 25.0
        layer.borderWidth   = 3.0
        layer.borderColor   = UIColor.black.cgColor
        clipsToBounds       = true
    }
    
    func setupNameLabel() {
        enterNameLabel.backgroundColor  = UIColor(red: 247.0 / 255.0, green: 147.0 / 255.0, blue: 26.0 / 255.0, alpha: 1.0)
        enterNameLabel.textAlignment    = .center
        enterNameLabel.textColor        = .white
        enterNameLabel.numberOfLines    = 0
        
        let text = "HELLO\nmy name is..."
        
        let boldAttributes          = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 36.0)
        ]
        
        let regularAttributes       = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0, weight: .regular)
        ]
        
        let attributedString        = NSMutableAttributedString(string: text, attributes: boldAttributes)
        attributedString.setAttributes(regularAttributes, range: NSMakeRange(6, text.count - 6))
        
        enterNameLabel.attributedText   = attributedString
    }
    
    func setupErrorLabel() {
        errorLabel.backgroundColor      = UIColor(red: 247.0 / 255.0, green: 147.0 / 255.0, blue: 26.0 / 255.0, alpha: 1.0)
        errorLabel.textAlignment        = .center
        errorLabel.font                 = UIFont.systemFont(ofSize: 12.0, weight: .semibold)
        errorLabel.text                 = ""
    }
    
    func setupNameTextField() {
        enterNameTextField.textAlignment    = .center
        enterNameTextField.borderStyle      = .none
        enterNameTextField.font             = UIFont.systemFont(ofSize: 32.0, weight: .semibold)
        enterNameTextField.textColor        = .black
    }
    
    func setupDoneButton() {
        doneButton.backgroundColor          = UIColor(red: 252.0 / 255.0, green: 76.0 / 255.0, blue: 15.0 / 255.0, alpha: 1.0)
        doneButton.titleLabel?.font         = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        doneButton.titleLabel?.text         = "Done"
        doneButton.tintColor                = .white
    }
}
