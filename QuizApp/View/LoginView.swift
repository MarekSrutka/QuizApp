//
//  LoginView.swift
//  QuizApp
//
//  Created by Marek Srutka on 04.03.2024.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    func didTapLogin()
}

class LoginView: UIView {
    
    // MARK: - Properties
    
    let stackView = UIStackView()
    let loginButton = QAButton(title: "Login", color: .black)
    let usernameTextField = QATextField()
    let nicknameTitleLabel = QALabel(textAlignment: .center, fontSize: 24, weight: .bold)
    let errorLabel = QALabel(textAlignment: .center, fontSize: 18, weight: .medium)
    
    weak var delegate: LoginViewDelegate?

    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Configuration
    
    private func setupUI() {
        configureStackView()
        configureNicknameLabel()
        configureTextField()
        configureErrorLabel()
        configureLoginButton()
    }
    
    private func configureStackView() {
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.layer.cornerRadius = 10
        
        stackView.addArrangedSubview(nicknameTitleLabel)
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(errorLabel)
        stackView.addArrangedSubview(loginButton)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
    }
    
    private func configureNicknameLabel() {
        nicknameTitleLabel.text = "Nickname"
    }
    
    private func configureTextField() {
        usernameTextField.resignFirstResponder()
        usernameTextField.text = "MarekSrutka" // Only for test
        usernameTextField.addConstraint(usernameTextField.heightAnchor.constraint(equalToConstant: 50))
    }
    
    private func configureErrorLabel() {
        errorLabel.isHidden = true
        errorLabel.text = "Please enter a nickname"
        errorLabel.textColor = .systemRed
    }
    
    private func configureLoginButton() {
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }
    
    // MARK: - Action
    
    @objc func didTapLogin() {
        delegate?.didTapLogin()
    }
}
