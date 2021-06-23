//
//  accountLoguinModel.swift
//  TestBankInterface
//
//  Created by George de Araújo Apostolakis on 04/06/21.
//

import Foundation

struct LoginModel: Codable {
    
    let customerName: String
    let accountNumber: String
    let branchNumber: String
    let checkingAccountBalance: Double
}
