//
//  UIViewController.swift
//  TestBankInterface
//
//  Created by George de Araújo Apostolakis on 27/05/21.
//
import UIKit

//MARK: - Tap to Leave

extension UIViewController {
    func hideKeyboardWhenTapHappens () {
        let tap = UITapGestureRecognizer (target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard () {
        view.endEditing(true)
    }
}
