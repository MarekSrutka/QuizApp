//
//  HeaderView.swift
//  QuizApp
//
//  Created by Marek Srutka on 23.02.2024.
//

import UIKit

class HeaderView: UIView {
    
    var greetings: String
    
    // MARK: - Properties
    
    let welcobeLabel = QALabel(textAlignment: .left, fontSize: 24)
    let usernameLabel = QALabel(textAlignment: .left, fontSize: 16)
    
    // MARK: - Init
    
    init(_ greetings: String) {
        self.greetings = greetings
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        configureWelcomeLabel()
        configureUsernameLabel()
    }
    
    private func configureWelcomeLabel() {
        addSubview(welcobeLabel)
        welcobeLabel.text = greetings
        
        NSLayoutConstraint.activate([
            welcobeLabel.topAnchor.constraint(equalTo: self.topAnchor),
            welcobeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            welcobeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    private func configureUsernameLabel() {
        addSubview(usernameLabel)
        usernameLabel.text = "@\(PersistanceManager.retrieveUser().username)"
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: welcobeLabel.bottomAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
}
