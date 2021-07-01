//
//  LoginViewModel.swift
//  TestBankInterface
//
//  Created by George de Araújo Apostolakis on 28/06/21.
//

import Foundation

protocol LoginViewModel {
    var didStartActivity: (() -> Void)? { get set }
    var didEndActivity: (() -> Void)? { get set }
    var didFailLoadLogin: ((String) -> Void)? { get set }
    var didValidateLogin: ((Bool) -> Void)? { get set }
    var didValidatePassword: ((Bool) -> Void)? { get set }
    
    func validateCredentials(login: String, password: String, mode: Int)
    func performLogin()
}
final class LoginViewModelImp1: LoginViewModel {
    
    //MARK: - Events
    
    var didStartActivity: (() -> Void)?
    var didEndActivity: (() -> Void)?
    var didFailLoadLogin: ((String) -> Void)?
    var didValidateLogin: ((Bool) -> Void)?
    var didValidatePassword: ((Bool) -> Void)?
    //MARK: - Propriets
    
    var coordinator: Coordinator
    var repository: Repository
    
    var loginModel: LoginModel = .init(customerName: "", accountNumber: "", branchNumber: "", checkingAccountBalance: 0.0)
    
    init(coordinator: Coordinator, repository: Repository) {
        self.coordinator = coordinator
        self.repository = repository
    }
    //MARK: - Methods
    
    func performLogin() {
        didStartActivity?()
        repository.performLogin(sucessHandler: {[weak self]clientInfo in
            self?.didEndActivity?()
            self?.coordinator.showStatementsScreen(clientInfo: clientInfo)
        }, errorHandler: {[weak self]errorMsg in
            self?.didEndActivity?()
            self?.didFailLoadLogin?(errorMsg)
        })
    }
    
    func validateCredentials(login: String, password: String, mode: Int) {
        switch mode {
        case 1:
            let validLogin = isValidEmail(login) || isValidCPF(login)
            didValidateLogin?(validLogin)
        case 2:
            let validPassword = isValidPassword(password)
            didValidatePassword?(validPassword)
        case 3:
            let validLogin = isValidEmail(login) || isValidCPF(login)
            let validPassword = isValidPassword(password)
            didValidateLogin?(validLogin)
            didValidatePassword?(validPassword)
        default:
            print("Wrong TextFieldTag Selected")
        }
    }
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func isValidCPF(_ cpf: String) -> Bool {
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
    
    private func isValidPassword (_ password: String) -> Bool{
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
}

