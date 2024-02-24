//
//  LoginViewController.swift
//  QuizApp
//
//  Created by Marek Srutka on 21.02.2024.
//

import UIKit


class LoginViewController: UIViewController {
    
    private let easyToUse = EasyToUse()
   
    private lazy var loginVw: LoginView = {
        
        let vw = LoginView { [weak self] userName in
            self?.clickLogin(userName: userName)
        }
        return vw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initializeHiddenKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        easyToUse.setGradientBackground(view)
        checkUserLogin()
    }
}


// MARK: - Private extension

private extension LoginViewController {
    
    // MARK: - Setup UI
    
    func setupUI() {
        
        self.view.addSubview(loginVw)
        
        NSLayoutConstraint.activate([
            loginVw.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            loginVw.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            loginVw.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
        ])
    }
    
    
    // MARK: - Functions
    
    func clickLogin(userName: String) {
        easyToUse.defaults.setValue(userName, forKey: "username")
        handleScreen()
    }
    
    func handleScreen() {
       displayMain()
    }
    
    func initializeHiddenKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        view.addGestureRecognizer(tap)
    }
    
    func checkUserLogin() {
        if ((easyToUse.defaults.string(forKey: "username")?.isEmpty) != nil) {
            handleScreen()
        }
    }
    
    func displayMain() {
        let vc = MyCustomTabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    
// MARK: - Objective C
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    

}
