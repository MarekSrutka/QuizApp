//
//  SettingsView.swift
//  QuizApp
//
//  Created by Marek Srutka on 23.02.2024.
//

import UIKit

class SettingsView: UIView {
    
    // MARK: - Properties
    
    let headerVw: HeaderView = {
        
        let vw = HeaderView("Welcome to settings ⚙️")
        
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        return vw
    }()
    
    private lazy var setting_logoutBtn = UIButton()
    
    private var action: () -> ()
    
    
// MARK: - Init
    
    init(action: @escaping () -> ()) {
        self.action = action
        super.init(frame: .zero)
        
        setupUI()
        configuration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: = Private extension

private extension SettingsView {
    
// MARK: - SetupUI
    
    func setupUI() {
        
        self.addSubview(headerVw)
        self.addSubview(setting_logoutBtn)
        
        NSLayoutConstraint.activate([
            headerVw.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            headerVw.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            headerVw.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            setting_logoutBtn.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            setting_logoutBtn.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            setting_logoutBtn.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
    }
    
    func configuration() {
        
        // UIButton
        setting_logoutBtn.configuration = .primary(with: .init(title: "logout", iconName: "ic_logout"))
        setting_logoutBtn.translatesAutoresizingMaskIntoConstraints = false
        setting_logoutBtn.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
    }
    
    
    // MARK: - Objective C
        
    @objc func didTapLogout() {
        action()
    }
}
