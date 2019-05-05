//
//  PopupErrorView.swift
//  BitcoinConversion
//
//  Created by Antonio Mayorga on 5/5/19.
//  Copyright © 2019 Rays Industrial Computers. All rights reserved.
//

import UIKit

class PopupErrorView: UIView {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    func setupViews() {
        setupMainView()
        setupErrorLabel()
        setupDoneButton()
    }
    
    func setupMainView() {
        layer.cornerRadius  = 25.0
        layer.borderWidth   = 3.0
        layer.borderColor   = UIColor.black.cgColor
        clipsToBounds       = true
        backgroundColor     = UIColor.white
        isHidden            = true
    }
    
    func setupErrorLabel() {
        errorLabel.backgroundColor      = UIColor(red: 247.0 / 255.0, green: 147.0 / 255.0, blue: 26.0 / 255.0, alpha: 1.0)
        errorLabel.textAlignment        = .center
        errorLabel.numberOfLines        = 0
        errorLabel.font                 = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        errorLabel.textColor            = .white
        errorLabel.text                 = "Error"
    }
    
    func setupDoneButton() {
        doneButton.backgroundColor      = UIColor(red: 252.0 / 255.0, green: 76.0 / 255.0, blue: 15.0 / 255.0, alpha: 1.0)
        doneButton.titleLabel?.font     = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        doneButton.titleLabel?.text     = "Done"
        doneButton.tintColor            = .white
    }

}
