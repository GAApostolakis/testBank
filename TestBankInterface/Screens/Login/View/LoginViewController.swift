//
//  LoguinViewController.swift
//  TestBankInterface
//
//  Created by George de Araújo Apostolakis on 26/05/21.
//
//MARK: - Imports
import UIKit

//MARK: - LoguinViewController Main Class:

class LoginViewController: UIViewController {
    //MARK: - Outletss:
    
    @IBOutlet weak var loginIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorDisplay: UILabel!
    @IBOutlet weak var errorDisplayII: UILabel!
    //MARK: - Inicialization & Actions:
    var loginPresenter = LoginPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginIdTextField.colorBorder(color: UIColor.lightPeriwinkle.cgColor, radius: 4.0)
        passwordTextField.colorBorder(color: UIColor.lightPeriwinkle.cgColor, radius: 4.0)
        loginButton.backgroundColor = UIColor.warmBlue
        
        loginPresenter.loginVC = self
        loginIdTextField.delegate = self
        passwordTextField.delegate = self
        self.hideKeyboardWhenTapHappens()
    }
    
    @IBAction func loguinPressed(_ sender: UIButton) {
        if loginPresenter.validateCredentials(login: loginIdTextField.text ?? "", password: passwordTextField.text ?? "", Mode: 3) {
            loginPresenter.requestLogin()
        }
    }
}
//MARK: - Extension UITextField Delegate:

extension LoginViewController: UITextFieldDelegate {
    //MARK: - TextField Should Return:
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return loginPresenter.validateCredentials(login: loginIdTextField.text ?? "", password: passwordTextField.text ?? "", Mode: textField.tag)
    }
    //MARK: - TextField Should End Editing:
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return loginPresenter.validateCredentials(login: loginIdTextField.text ?? "", password: passwordTextField.text ?? "", Mode: textField.tag)
    }
}



