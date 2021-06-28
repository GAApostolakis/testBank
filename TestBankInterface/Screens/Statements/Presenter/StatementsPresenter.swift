//
//  StatementsPresenter.swift
//  TestBankInterface
//
//  Created by George de Araújo Apostolakis on 18/06/21.
//
import Foundation
import Moya

protocol StatementsPresenter {
    var clientInfoViewData: ClientInfoViewData { get }
    var statementsViewData: StatementsViewData { get }
    
    func requestStatements()
    func logOut()
}

protocol StatementsPresenterOutput {
    func reloadData()
    func displayconnectionError(e: String)
}

class StatementsPresenterImpl: StatementsPresenter {
    //MARK: - Variables & Init:
    
    var repository: Repository
    var coordinator: Coordinator
    var clientInfo: LoginModel
    var clientInfoViewData: ClientInfoViewData

    var statements: StatementsModel?
    var statementsVC: StatementsPresenterOutput?
    var statementsViewData: StatementsViewData = .init(package: [])
    
    init(coordinator: Coordinator, repository: Repository, clientInfo: LoginModel){
        self.coordinator = coordinator
        self.repository = repository
        self.clientInfo = clientInfo
        self.clientInfoViewData = ClientInfoViewData(
                                name: clientInfo.customerName,
                                accNumber: clientInfo.accountNumber,
                                balanceValue: String(format: "R$ %.2f",
                                                     clientInfo.checkingAccountBalance ))
    }
//MARK: - Methods
    
    func requestStatements() {
        repository.performStatements(sucessHandler: {[weak self]statements in
            for op in statements.statement {
                let formatter = NumberFormatter()
                formatter.allowsFloats = true
                formatter.alwaysShowsDecimalSeparator = true
                formatter.currencyCode = "brl"
                formatter.currencySymbol = "R$ "
                formatter.maximumFractionDigits = 2
                formatter.numberStyle = .currency
                formatter.locale = Locale(identifier: "pt_BR")
                
                let value = formatter.string(from: NSNumber(floatLiteral: Double(op.value))) ?? ""
                
                let operation = Operation(type: op.type, detail: op.detail, date: op.date, value: value)
                self?.statementsViewData.package.append(operation)
            }
            
            self?.statementsVC?.reloadData()
        }, errorHandler: {[weak self]e in
            self?.statementsVC?.displayconnectionError(e: e)
        })
    }
    
    func logOut() {
        coordinator.dismiss()
    }
}

