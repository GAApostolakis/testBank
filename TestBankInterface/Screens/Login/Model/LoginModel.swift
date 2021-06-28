//
//  accountLoguinModel.swift
//  TestBankInterface
//
//  Created by George de Araújo Apostolakis on 04/06/21.
//
struct LoginModel: Codable {
    let customerName: String
    let accountNumber: String
    let branchNumber: String
    let checkingAccountBalance: Double
}
