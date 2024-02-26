//
//  RouterVC.swift
//  QuizApp
//
//  Created by Marek Srutka on 24.02.2024.
//

import UIKit

class RouterVC: UIViewController {
    
    private let easyToUse = EasyToUse()
    private var loginScreen: LoginScreens = .login

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkIfuserLogin()
    }
}


// MARK: - Private extension {

private extension RouterVC {
    
// MARK: - Functions
    
    func checkIfuserLogin() {
        if easyToUse.defaults.string(forKey: "username")?.isEmpty != nil {
            handleScreen(with: .main)
        } else {
            handleScreen(with: .login)
        }
    }
    
    
// MARK: - Navigation
    
    func handleScreen(with screens: LoginScreens) {
        switch screens {
        case .login:
            return displayLogin()
        case .main:
            return displayMain()
        }
    }
    
    func displayLogin() {
        let vc = LoginVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    func displayMain() {
        let vc = MyCustomTabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
}

