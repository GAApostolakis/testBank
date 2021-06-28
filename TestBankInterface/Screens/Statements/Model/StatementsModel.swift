//
//  accountStatementsModel.swift
//  TestBankInterface
//
//  Created by George de Araújo Apostolakis on 04/06/21.
//
struct StatementsModel: Codable {
    let statement: [Op]
}

struct Op: Codable {
    let id: Int
    let type: String
    let date: String
    let detail: String
    let value: Float
}
