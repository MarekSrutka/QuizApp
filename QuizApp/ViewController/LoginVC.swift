//
//  LoginVC.swift
//  QuizApp
//
//  Created by Marek Srutka on 21.02.2024.
//

import UIKit

class LoginVC: UIViewController {
   
    // MARK: - Properties
    
    let loginView = LoginView()
    
    var isUsernameEntered: Bool { return !loginView.usernameTextField.text!.isEmpty }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        delegates()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - UI Setup
    
    func setupUI() {
        configureViewController()
        configureLoginView()
    }
    
    func configureViewController() {
        EasyToUse.setGradientBackground(view, colorTop: ColorGradient.topColor, colorBottom: ColorGradient.bottomColor)
    }
    
    func delegates() {
        loginView.delegate = self
        loginView.usernameTextField.delegate = self
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    func configureLoginView() {
        view.addSubview(loginView)
        loginView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        loginView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }
    
    // MARK: - Login Button Handling
    
    func tapLoginButton() {
        loginView.errorLabel.isHidden = true
        guard isUsernameEntered else {
            loginView.errorLabel.isHidden = false
            return
        }
        
        let user: User = User(username: loginView.usernameTextField.text ?? "")
        
        PersistanceManager.saveUser(user)
        
        let vc = MyCustomTabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
}

// MARK: - LoginViewDelegate

extension LoginVC: LoginViewDelegate {
    func didTapLogin() {
        tapLoginButton()
    }
}

// MARK: - UITextFieldDelegate

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tapLoginButton()
        return true
    }
}
