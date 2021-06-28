//
//  File.swift
//  TestBankInterface
//
//  Created by George de Araújo Apostolakis on 25/06/21.
//

import UIKit

protocol Coordinator {
    var currentVC: UIViewController? {get set}
    func start()
    func showStatementsScreen(clientInfo: LoginModel)
    func dismiss()
}
