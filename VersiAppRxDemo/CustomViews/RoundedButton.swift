//
//  RoundedButton.swift
//  VersiAppRxDemo
//
//  Created by Mahmoud Abdul-Wahab on 20/03/2021.
//

import UIKit
@IBDesignable
class RoundedButton: UIButton {

    override  func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor    = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        layer.borderColor  = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layer.cornerRadius = frame.height / 2
        layer.borderWidth  = 3
    }

}
