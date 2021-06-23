//
//  LoguinPresenter.swift
//  TestBankInterface
//
//  Created by George de Araújo Apostolakis on 27/05/21.
//
//MARK: - Imports
import UIKit
import Moya

//MARK: - Class
class LoginPresenter {
    
    var clientInfo: LoginModel?
    var error: String?
    let provider = MoyaProvider<TargetBank>()
    
    var loginVC: LoginViewController?
    var statementVC = StatementsViewController()
    
    let invalidLogin = "* Invalid Login, please use a CPF or E-mail!"
    let invalidPassword = "* Password should have at least one uppercase letter, one special character and one alphanumeric character."
    let connectionError = "Error connecting to the server"
    
    //MARK: - Is Valid Email Format?
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
    //MARK: - Is Valid CPF Format?
    
    func isValidCPF(_ cpf: String) -> Bool {
        //Edit:*
        var cpfRegEx = "[0-9]{3}[.][0-9]{3}[.][0-9]{3}[-][0-9]{2}"
        var cpfPred = NSPredicate(format:"SELF MATCHES %@", cpfRegEx)
        if cpfPred.evaluate(with: cpf) == true {
            return cpfPred.evaluate(with: cpf)
        } else {
            cpfRegEx = "[0-9]{11}"
            cpfPred = NSPredicate(format:"SELF MATCHES %@", cpfRegEx)
            return cpfPred.evaluate(with: cpf)
        }
    }
    
    //MARK: - Is Valid Password Format?
    
    func isValidPassword (_ password: String) -> Bool{
        var passwordRegEx = ".*[A-Z]+.*"
        var passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        let upperCase = passwordPred.evaluate(with: password)
        
        passwordRegEx = ".*\\d+.*"
        passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        let alphaNumeric = passwordPred.evaluate(with: password)
        
        passwordRegEx = ".*\\W+.*"
        passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        let specialCharacter = passwordPred.evaluate(with: password)
        
        return upperCase && alphaNumeric && specialCharacter
    }
    
    
    //MARK: - resquestLoguin
    
    func requestLogin (){
        
        var feedback: String?
        
        provider.request(.login) { result in
            
            switch result {
            case .success (let response):
                do {
                    self.clientInfo = try response.map(LoginModel.self)
                    feedback = ""
                    print("Loguin Request was a Sucess!")
                    self.statementVC.statementsPresenter.clientInfo = self.clientInfo
                    self.loginVC?.present(self.statementVC, animated: true)
                    
                } catch {
                    feedback = error.localizedDescription.description
                    print(feedback!)
                }
            case .failure:
                feedback = "Server unavailable"
                print(feedback!)
            }
        }
    }
    
    //MARK: - longuinAtempt
    
    func validateCredentials(login: String, password: String, Mode: Int) -> Bool {
        
        switch Mode {
        case 1:
            if isValidCPF(login)||isValidEmail(login) {
                return true
            } else{
                loginVC?.errorDisplay.text = invalidLogin
                return false
            }
        case 2:
            if isValidPassword(password) {
                return true
            } else {
                loginVC?.errorDisplayII.text = invalidPassword
                return false
            }
        case 3:
            if isValidCPF(login)||isValidEmail(login) {
                if isValidPassword(password) {
                    return true
                } else {
                    loginVC?.errorDisplayII.text = invalidPassword
                    return false
                }
            } else{
                loginVC?.errorDisplay.text = invalidLogin
                return false
            }
        default:
            print("TextField Login Screen Unexpected TAG.")
            return false
        }
        
    }
    
}
