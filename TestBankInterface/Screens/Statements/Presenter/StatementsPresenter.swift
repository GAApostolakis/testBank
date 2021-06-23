//
//  StatementsPresenter.swift
//  TestBankInterface
//
//  Created by George de Araújo Apostolakis on 18/06/21.
//

import Foundation
import Moya

class StatementsPresenter {
    
    //MARK: - Variables:
    let tableCellIdentifier = "opCell"
    let tableCellName = "TableViewCell"
    var clientInfo: LoginModel?
    var operations: StatementsModel?
    var statementVC: StatementsViewController?
    let provider = MoyaProvider<TargetBank>()
    
    //MARK: - requestOperations
    func requestOperations() {
        
        provider.request(.statements) { result in
            switch result {
            case .success (let response):
                do {
                    self.operations = try response.map(StatementsModel.self)
                    print("Operation Request was a Sucess!")
                    self.statementVC?.tableView.reloadData()
                    
                } catch {
                    print(error.localizedDescription.description)
                }
            case .failure: break
            }
        }
    }
    
    func logOut() {
        statementVC?.dismiss(animated: true, completion: nil)
    }
    
    func setClientLabels() {
        statementVC?.nameLabel.text = clientInfo?.customerName
        statementVC?.accountNumberLabel.text = clientInfo?.accountNumber
        statementVC?.balanceValueLabel.text = String(format: "R$ %.2f", clientInfo?.checkingAccountBalance ?? 0)
    }
}
