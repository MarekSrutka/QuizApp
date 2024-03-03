//
//  RouterVC.swift
//  QuizApp
//
//  Created by Marek Srutka on 24.02.2024.
//

import UIKit

enum AppScreen {
    case login
    case main
}

class RouterVC: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkIfUserIsLoggedIn()
    }
    
    private func checkIfUserIsLoggedIn() {
        if PersistanceManager.doesUserExist() {
            navigate(to: .main)
        } else {
            navigate(to: .login)
        }
    }
    
    func navigate(to screen: AppScreen) {
        let viewController: UIViewController
        
        switch screen {
        case .login:
            viewController = LoginVC()
        case .main:
            viewController = MyCustomTabBarController()
        }
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: false)
    }
}
