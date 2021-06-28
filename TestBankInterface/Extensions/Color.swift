//
//  Color.swift
//  TestBankInterface
//
//  Created by George de Araújo Apostolakis on 24/06/21.
//

import UIKit
struct Color {
    func createColor (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
}
