//
//  Repository.swift
//  TestBankInterface
//
//  Created by George de Araújo Apostolakis on 27/06/21.
//

import Foundation

protocol Repository {
    func performLogin(sucessHandler: @escaping (LoginModel) -> Void, errorHandler: @escaping (String) -> Void)
    func performStatements(sucessHandler: @escaping (StatementsModel) -> Void, errorHandler: @escaping (String) -> Void)
}
