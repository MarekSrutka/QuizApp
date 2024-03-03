//
//  LoginVC.swift
//  QuizApp
//
//  Created by Marek Srutka on 21.02.2024.
//

import UIKit


class LoginVC: UIViewController {
   
    let contentView = UIView()
    let stackView = UIStackView()
    let loginButton = QAButton(title: "Login", color: .black)
    let usernameTextField = QATextField()
    let nicknameTitleLabel = QALabel(textAlignment: .center, fontSize: 24)
    let errorLabel = QALabel(textAlignment: .center, fontSize: 18)
    
    var isUsernameEntered: Bool { return !usernameTextField.text!.isEmpty }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupUI() {
        configureViewController()
        configureContentView()
        configureStackView()
        configureNicknameLabel()
        configureTextField()
        configureErrorLabel()
        configureLoginButton()
    }
    
    func configureViewController() {
        EasyToUse.setGradientBackground(view, colorTop: ColorGradient.topColor, colorBottom: ColorGradient.bottomColor)
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    func configureContentView() {
        view.addSubview(contentView)
        contentView.addSubview(stackView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        NSLayoutConstraint.activate([
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }
    
    func configureStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.layer.cornerRadius = 10
        
        stackView.addArrangedSubview(nicknameTitleLabel)
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(errorLabel)
        stackView.addArrangedSubview(loginButton)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
    
    func configureNicknameLabel() {
        nicknameTitleLabel.text = "Nickname"
    }
    
    func configureTextField() {
        usernameTextField.delegate = self
        usernameTextField.resignFirstResponder()
        usernameTextField.addConstraint(usernameTextField.heightAnchor.constraint(equalToConstant: 50))
    }
    
    func configureErrorLabel() {
        errorLabel.isHidden = true
        errorLabel.text = "Please enter nickname"
        errorLabel.textColor = .systemRed
    }
    
    func configureLoginButton() {
        loginButton.addTarget(self, action: #selector(pushMainVC), for: .touchUpInside)
    }
    
    @objc func pushMainVC() {
        errorLabel.isHidden = true
        guard isUsernameEntered else  {
            errorLabel.isHidden = false
            return
        }
        
        let user: User = User(username: usernameTextField.text ?? "")
        
        PersistanceManager.saveUser(user)
        
        let vc = MyCustomTabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
}

// MARK: - UITextField Delegate

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushMainVC()
        return true
    }
}
