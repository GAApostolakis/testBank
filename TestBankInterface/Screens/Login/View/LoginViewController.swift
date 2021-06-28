//
//  LoguinViewController.swift
//  TestBankInterface
//
//  Created by George de Araújo Apostolakis on 26/05/21.
//
import UIKit

class LoginViewController: UIViewController {
    //MARK: - Outlets & Variables
    
    @IBOutlet weak var loginIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorDisplay: UILabel!
    @IBOutlet weak var errorDisplayII: UILabel!

    
    var loginPresenter: LoginPresenterProtocol
    let invalidLogin = "* Invalid Login, please use a CPF or E-mail!"
    let invalidPassword = "* Password should have at least one uppercase letter, one special character and one alphanumeric character."
    //MARK: - Inicialization & Actions
    
    init(presenter: LoginPresenterProtocol) {
        self.loginPresenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginIdTextField.colorBorder(UIColor.lightPeriwinkle.cgColor, radius: 4.0)
        passwordTextField.colorBorder(UIColor.lightPeriwinkle.cgColor, radius: 4.0)
        loginButton.backgroundColor = UIColor.warmBlue

        loginIdTextField.delegate = self
        passwordTextField.delegate = self
        self.hideKeyboardWhenTapHappens()
    }

    @IBAction func loguinPressed(_ sender: UIButton) {
        if loginPresenter.validateCredentials(login: loginIdTextField.text ?? "", password: passwordTextField.text ?? "", Mode: 3) {
            loginPresenter.requestLogin()
        }
    }
    //MARK: - Methods
    
    func displayError(msgError: String, displayError: Int) {
        switch displayError {
        case 1:
            errorDisplay.text = invalidLogin
        case 2:
        errorDisplayII.text = invalidPassword
        case 3:
            errorDisplayII.text = msgError
        default:
            print("Invalid Error Selected!")
        }
    }

    func displayconnectionError(e: String) {
        let alert = UIAlertController(title: "Error:", message: e, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - TextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return loginPresenter.validateCredentials(login: loginIdTextField.text ?? "", password: passwordTextField.text ?? "", Mode: textField.tag)
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return loginPresenter.validateCredentials(login: loginIdTextField.text ?? "", password: passwordTextField.text ?? "", Mode: textField.tag)
    }
}



