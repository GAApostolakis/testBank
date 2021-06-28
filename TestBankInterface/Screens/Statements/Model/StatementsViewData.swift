//
//  File.swift
//  TestBankInterface
//
//  Created by George de Araújo Apostolakis on 25/06/21.
//

import Foundation

struct StatementsViewData {
    var package: [Operation]
}
struct Operation {
    var type, detail, date, value: String
}

