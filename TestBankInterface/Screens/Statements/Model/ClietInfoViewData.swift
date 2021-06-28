//
//  ClietInfoViewData.swift
//  TestBankInterface
//
//  Created by George de Araújo Apostolakis on 24/06/21.
//
struct ClientInfoViewData {
    var name, accNumber, balanceValue: String
    
    init(name: String, accNumber: String, balanceValue: String) {
        self.name = name
        self.accNumber = accNumber
        self.balanceValue = balanceValue
    }
}
