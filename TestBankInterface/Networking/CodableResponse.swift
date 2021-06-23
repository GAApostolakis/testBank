//
//  CodableResponse.swift
//  TestBankInterface
//
//  Created by George de Araújo Apostolakis on 06/06/21.
//

import Foundation

struct LoguinResponse: Codable  {
    let data: LoginModel
    let code: Int
}


