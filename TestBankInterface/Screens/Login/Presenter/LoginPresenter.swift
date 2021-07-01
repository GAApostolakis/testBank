////
////  LoguinPresenter.swift
////  TestBankInterface
////
////  Created by George de Araújo Apostolakis on 27/05/21.
////
//
//import UIKit
//import Moya
//
//protocol LoginPresenterProtocol {
//    func validateCredentials(login: String, password: String, Mode: Int) -> Bool
//    func requestLogin()
//}
//
//class LoginPresenter: LoginPresenterProtocol {
//    //MARK: - Variables
//
//    var repository: Repository
//    var coordinator: Coordinator
//    var loginVC: LoginViewController?
//    let connectionError = "Error connecting to the server"
//
//    init (coordinator: Coordinator, repository: Repository) {
//        self.coordinator = coordinator
//        self.repository = repository
//    }
//    //MARK: - Is Valid Email Format?
//
//    func isValidEmail(_ email: String) -> Bool {
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//
//        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        return emailPred.evaluate(with: email)
//    }
//    //MARK: - Is Valid CPF Format?
//
//    func isValidCPF(_ cpf: String) -> Bool {
//        //Edit:*
//        var cpfRegEx = "[0-9]{3}[.][0-9]{3}[.][0-9]{3}[-][0-9]{2}"
//        var cpfPred = NSPredicate(format:"SELF MATCHES %@", cpfRegEx)
//        if cpfPred.evaluate(with: cpf) == true {
//            return cpfPred.evaluate(with: cpf)
//        } else {
//            cpfRegEx = "[0-9]{11}"
//            cpfPred = NSPredicate(format:"SELF MATCHES %@", cpfRegEx)
//            return cpfPred.evaluate(with: cpf)
//        }
//    }
//    //MARK: - Is Valid Password Format?
//
//    func isValidPassword (_ password: String) -> Bool{
//        var passwordRegEx = ".*[A-Z]+.*"
//        var passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
//        let upperCase = passwordPred.evaluate(with: password)
//
//        passwordRegEx = ".*\\d+.*"
//        passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
//        let alphaNumeric = passwordPred.evaluate(with: password)
//
//        passwordRegEx = ".*\\W+.*"
//        passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
//        let specialCharacter = passwordPred.evaluate(with: password)
//
//        return upperCase && alphaNumeric && specialCharacter
//    }
//    //MARK: - resquestLoguin
//
//    func requestLogin(){
////        repository.performLogin {[weak self](clientInfo) in
////        }{[weak self](feedback) in
////        }
//        repository.performLogin(sucessHandler: {[weak self]clientInfo in
//            self?.coordinator.showStatementsScreen(clientInfo: clientInfo)
//        }, errorHandler: {[weak self]e in
//            self?.loginVC?.displayconnectionError(e: e)
//        })
//    }
//
//    //MARK: - validateCredentials
//
//    func validateCredentials(login: String, password: String, Mode: Int) -> Bool {
//
//        switch Mode {
//        case 1:
//            if isValidCPF(login)||isValidEmail(login) {
//                return true
//            } else{
//                loginVC?.displayError(msgError: "", displayError: Mode)
//                return false
//            }
//        case 2:
//            if isValidPassword(password) {
//                return true
//            } else {
//                loginVC?.displayError(msgError: "", displayError: Mode)
//                return false
//            }
//        case 3:
//            if isValidCPF(login)||isValidEmail(login) {
//                if isValidPassword(password) {
//                    return true
//                } else {
//                    loginVC?.displayError(msgError: "", displayError: 2)
//                    return false
//                }
//            } else{
//                loginVC?.displayError(msgError: "", displayError: 1)
//                return false
//            }
//        default:
//            print("TextField Login Screen Unexpected TAG.")
//            return false
//        }
//    }
//}
//
