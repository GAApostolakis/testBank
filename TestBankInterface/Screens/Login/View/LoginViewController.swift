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
    
    
    var viewModel: LoginViewModel
    let invalidLogin = "* Invalid Login, please use a CPF or E-mail!"
    let invalidPassword = "* Password should have at least one uppercase letter, one special character and one alphanumeric character."
    var loginOk: Bool = false
    var passwordOk: Bool = false
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.frame = UIScreen.main.bounds
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.warmBlue
        
        return activityIndicator
    }()
    //MARK: - Inicialization & Actions
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpBindings()
        self.hideKeyboardWhenTapHappens()
    }
    
    @IBAction func loguinPressed(_ sender: UIButton) {
        viewModel.validateCredentials(login: loginIdTextField.text ?? "", password: passwordTextField.text ?? "", mode: 3)
        if loginOk && passwordOk {
            viewModel.performLogin()
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
    
    func setUpUI () {
        loginIdTextField.colorBorder(UIColor.lightPeriwinkle.cgColor, radius: 4.0)
        passwordTextField.colorBorder(UIColor.lightPeriwinkle.cgColor, radius: 4.0)
        loginButton.backgroundColor = UIColor.warmBlue
        loginIdTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func setUpBindings() {
        viewModel.didStartActivity = {[weak self] in
            self?.activityIndicator.startAnimating()
        }
        
        viewModel.didEndActivity = {[weak self] in
            self?.activityIndicator.stopAnimating()
        }
        
        viewModel.didFailLoadLogin = {[weak self] errorMsg in
            let alert = UIAlertController(title: "Error:", message: errorMsg, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
        
        viewModel.didValidateLogin = {[weak self] validLogin in
            if validLogin {
                self?.errorDisplay.text = ""
                self?.loginOk = true
            } else {
                self?.errorDisplay.text = self?.invalidLogin
                self?.loginOk = false
            }
        }
        
        viewModel.didValidatePassword = {[weak self] validPassword in
            if validPassword {
                self?.errorDisplayII.text = ""
                self?.passwordOk = true
            } else {
                self?.errorDisplayII.text = self?.invalidPassword
                self?.passwordOk = false
            }
        }
    }
}
//MARK: - TextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag{
        case 1:
            viewModel.validateCredentials(login: loginIdTextField.text ?? "", password: passwordTextField.text ?? "", mode: textField.tag)
            return loginOk
        case 2:
            viewModel.validateCredentials(login: loginIdTextField.text ?? "", password: passwordTextField.text ?? "", mode: textField.tag)
            return passwordOk
        default:
            return true
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        switch textField.tag{
        case 1:
            viewModel.validateCredentials(login: loginIdTextField.text ?? "", password: passwordTextField.text ?? "", mode: textField.tag)
            return loginOk
        case 2:
            viewModel.validateCredentials(login: loginIdTextField.text ?? "", password: passwordTextField.text ?? "", mode: textField.tag)
            return passwordOk
        default:
            return true
        }
    }
}



