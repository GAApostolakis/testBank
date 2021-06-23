//
//  UITextField.swift
//  TestBankInterface
//
//  Created by George de Araújo Apostolakis on 26/05/21.
//

import UIKit

extension UITextField
{
    func colorBorder(color color: CGColor, radius value: CGFloat) {
        self.layer.borderColor = color
        self.layer.borderWidth = 2
        self.layer.masksToBounds = false
        self.layer.cornerRadius = value
    }
}
