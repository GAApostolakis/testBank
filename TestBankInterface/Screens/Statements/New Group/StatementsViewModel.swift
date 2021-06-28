//
//  StatementsViewModel.swift
//  TestBankInterface
//
//  Created by George de Araújo Apostolakis on 28/06/21.
//

import Foundation

//MARK: - Protocols

protocol StatementsViewModel {
    var didStartActivity: (() -> Void)? { get set }
    var didEndActivity: (() -> Void)? { get set }
    var didLoadedStatements: (() -> Void)? { get set }
    
    var clientInfoViewData: ClientInfoViewData { get }
    var statementsViewData: StatementsViewData { get }
    
    func fetchStatements()
    func logOut()
}

//MARK: - Class

final class StatementsViewModelImpl: StatementsViewModel {
    
    //MARK: - Events
    
    var didStartActivity: (() -> Void)?
    var didEndActivity: (() -> Void)?
    var didLoadedStatements: (() -> Void)?
    
    //MARK: - Properties
    
    var clientInfoViewData: ClientInfoViewData {
        return .init(
            name: loginModel.customerName,
            accNumber: loginModel.accountNumber,
            balanceValue: String(format: "R$ %.2f", loginModel.checkingAccountBalance)
        )
    }
    
    var statementsViewData: StatementsViewData {
        let statements: [Operation] = statementsModel?.statement.map({ op in
            let operation = Operation(type: op.type,
                                      detail: op.detail,
                                      date: op.date,
                                      value: String(format: "R$ %.2f", op.value))
            
            return operation
        }) ?? []
        
        return .init(package: statements)
    }
    
    private var coordinator: Coordinator
    private var repository: Repository
    
    private var loginModel: LoginModel
    private var statementsModel: StatementsModel?
    
    init(coordinator: Coordinator, repository: Repository, loginModel: LoginModel) {
        self.coordinator = coordinator
        self.repository = repository
        self.loginModel = loginModel
    }

    //MARK: - Methods
    
    func fetchStatements() {
        didStartActivity?()
        
        repository.performStatements { [weak self] statementsModel in
            self?.didEndActivity?()
            
            self?.statementsModel = statementsModel
            self?.didLoadedStatements?()
        } errorHandler: { [weak self] errorMessage in
            self?.didEndActivity?()
        }

    }
    
    func logOut() {
        coordinator.dismiss()
    }
}
