//
//  AppCoordinator.swift
//  TestBankInterface
//
//  Created by George de Araújo Apostolakis on 25/06/21.
//

import UIKit

class AppCoordinator: Coordinator {
    var window: UIWindow
    var currentVC: UIViewController?
    
    init (window: UIWindow){
        self.window = window
    }
    func start() {
        let repository = RepositoryAPI()
        let presenter = LoginPresenter(coordinator: self, repository: repository)
        let login = LoginViewController(presenter: presenter)
        currentVC = login
        presenter.loginVC = login
        window.rootViewController = login
        window.makeKeyAndVisible()
    }
    func showStatementsScreen(clientInfo: LoginModel) {
        let repository = RepositoryAPI()
        let presenter = StatementsPresenterImpl(
            coordinator: self,
            repository: repository,
            clientInfo: clientInfo
        )
        let statementsVC = StatementsViewController(presenter: presenter)
        presenter.statementsVC = statementsVC
        
        statementsVC.modalTransitionStyle = .crossDissolve
        statementsVC.modalPresentationStyle = .overFullScreen
        currentVC?.present(
            statementsVC,
            animated: true,
            completion: nil
        )
        currentVC = statementsVC
    }
    func dismiss() {
        let parentVC = currentVC?.presentingViewController
        currentVC?.dismiss(animated: true, completion: {
            self.currentVC = parentVC
        })
    }
}
