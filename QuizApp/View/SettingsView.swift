//
//  SettingsView.swift
//  QuizApp
//
//  Created by Marek Srutka on 23.02.2024.
//

import UIKit

protocol SettingsViewDelegate: AnyObject {
    func didTapLogout()
}

class SettingsView: UIView {
    
    // MARK: - Properties
    
    let headerView = HeaderView("Welcome to settings ⚙️")
    var logoutButton = QAButton(title: "Logout", color: .black)
    
    weak var delegate: SettingsViewDelegate?
    
    
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
        configureHeaderView()
        configureLogoutButton()
    }
    
    private func configureHeaderView() {
        self.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func configureLogoutButton() {
        self.addSubview(logoutButton)
        logoutButton.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            logoutButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            logoutButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            logoutButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
    }
    
    // MARK: - Action
    
    @objc func didTapLogout() {
        delegate?.didTapLogout()
    }
}
