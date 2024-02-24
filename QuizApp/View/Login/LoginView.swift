//
//  LoginView.swift
//  QuizApp
//
//  Created by Marek Srutka on 22.02.2024.
//

import UIKit

class LoginView: UIView {
    
// MARK: - Properties
    
    private lazy var login_btn = UIButton()
    
    private lazy var login_nicknameField = UITextField()
    
    private lazy var login_nicknameLbl: UILabel = {
        let lbl = UILabel()
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Nickname"
        lbl.font = .systemFont(ofSize: 24, weight: .bold)
        
        return lbl
    }()
    
    private lazy var login_errorLbl: UILabel = {
        let lbl = UILabel()
        
        lbl.isHidden = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 18, weight: .semibold)
        
        return lbl
    }()
    
    private lazy var login_stackVw: UIStackView = {
        let vw = UIStackView()
        
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.axis = .vertical
        vw.spacing = 15
        
        return vw
    }()
    
    private var action: (_ userName: String) -> ()
    
    private var loginStatus: LoginStatus = .none
    
    
// MARK: - Init
    
    init(action: @escaping (_ userName: String) -> ()) {
        self.action = action
        super.init(frame: .zero)
        
        setupUI()
        configuration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
    }
}


// MARK: - Private extension

private extension LoginView {
    
// MARK: - Setup UI
    
    func setupUI() {
        self.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        self.layer.cornerRadius = 10
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(login_stackVw)
        
        login_stackVw.addArrangedSubview(login_nicknameLbl)
        login_stackVw.addArrangedSubview(login_nicknameField)
        login_stackVw.addArrangedSubview(login_errorLbl)
        login_stackVw.addArrangedSubview(login_btn)
        
        NSLayoutConstraint.activate([
            login_stackVw.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            login_stackVw.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            login_stackVw.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            login_stackVw.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
    }
    
    
// MARK: - Functions
    
    func configuration() {
        // UITextField
        login_nicknameField.delegate = self
        login_nicknameField.backgroundColor = .systemBackground
        login_nicknameField.layer.cornerRadius = 10
        login_nicknameField.placeholder = "Enter your nickname"
        login_nicknameField.autocorrectionType = .no
        login_nicknameField.returnKeyType = .done
        login_nicknameField.clearButtonMode = .whileEditing
        login_nicknameField.borderStyle = .roundedRect
        login_nicknameField.translatesAutoresizingMaskIntoConstraints = false
        login_nicknameField.addConstraint(login_nicknameField.heightAnchor.constraint(equalToConstant: 50))
        login_nicknameField.imageSetup(imageName: "ic_field_nickname")
        
        // UIButton
        login_btn.configuration = .primary(with: .init(title: "login", iconName: "ic_login"))
        login_btn.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }
    
    func validateNicknameField() {
        if login_nicknameField.text == "" {
            login_errorLbl.isHidden = false
            login_errorLbl.text = "Please enter your nickname"
            login_errorLbl.textColor = .systemRed
            loginStatus = .failed
        } else {
            login_errorLbl.isHidden = true
            loginStatus = .success
        }
    }
    
    
// MARK: - Objective C
    
    @objc func didTapLogin() {
        validateNicknameField()
        
        switch loginStatus {
        case .success:
            return action(login_nicknameField.text ?? "")
        case .failed:
            return print("Failed Login")
        case .none:
            break
        }
    }
}


// MARK: - UITextField Delegate

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.endEditing(true)
        return true
    }
}
