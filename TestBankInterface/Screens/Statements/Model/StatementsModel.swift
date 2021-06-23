//
//  accountStatementsModel.swift
//  TestBankInterface
//
//  Created by George de Araújo Apostolakis on 04/06/21.
//

import Foundation

struct StatementsModel: Codable {
    
    let statement: [ID]
}

struct ID: Codable {
    let id: Int
    let type: String
    let date: String
    let detail: String
    let value: Float
}
