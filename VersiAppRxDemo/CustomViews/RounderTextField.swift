//
//  RounderTextField.swift
//  VersiAppRxDemo
//
//  Created by Mahmoud Abdul-Wahab on 20/03/2021.
//

import UIKit
class RounderTextField: UITextField {

    override  func awakeFromNib() {
        super.awakeFromNib()
        let placeHolder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor :#colorLiteral(red: 0.3442408442, green: 0.5524554849, blue: 0.9224796891, alpha: 1) ])
        backgroundColor    = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layer.cornerRadius = frame.height / 2
        layer.borderColor  = #colorLiteral(red: 0.3442408442, green: 0.5524554849, blue: 0.9224796891, alpha: 1)
        layer.borderWidth  = 3
        attributedPlaceholder = placeHolder
    }

}
