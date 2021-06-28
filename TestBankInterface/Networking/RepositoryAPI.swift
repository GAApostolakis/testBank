//
//  Repository.swift
//  TestBankInterface
//
//  Created by George de Araújo Apostolakis on 27/06/21.
//

import Foundation
import Moya


struct RepositoryAPI: Repository {

    let provider = MoyaProvider<BankTarget>()
    
    func performLogin(sucessHandler: @escaping (LoginModel) -> Void, errorHandler: @escaping (String) -> Void) {
        provider.request(.login) { result in
            switch result {
            case .success (let response):
                do {
                    let clientInfo = try response.map(LoginModel.self)
                    print("Loguin Request was a Sucess!")
                    sucessHandler(clientInfo)
                } catch {
                    errorHandler(error.localizedDescription.description)
                }
            case .failure:
                errorHandler("Server Unavailable")
            }
        }
    }
    
    func performStatements(sucessHandler: @escaping (StatementsModel) -> Void, errorHandler: @escaping (String) -> Void) {
        provider.request(.statements) { result in
            switch result {
            case .success (let response):
                do {
                    let statements = try response.map(StatementsModel.self)
                    print("Operation Request was a Sucess!")
                    sucessHandler(statements)
                } catch {
                    errorHandler(error.localizedDescription.description)
                }
            case .failure:
                errorHandler("Server Unavailable")
            }
        }
    }
}
