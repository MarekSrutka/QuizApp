//
//  QATextField.swift
//  QuizApp
//
//  Created by Marek Srutka on 02.03.2024.
//

import UIKit

class QATextField: UITextField {
    
    let iconImageView = UIImageView()
    
    var iconSize: CGSize = CGSize(width: 10.0, height: 10.0)
    let iconSpacing: CGFloat = 8.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        imageSetup(imageName: "ic_field_nickname")
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .left
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        returnKeyType = .go
        clearButtonMode = .whileEditing
        placeholder = "Enter a username"
    }
    
    private func imageSetup(imageName: String) {
        let iconImageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 25, height: 25))
        iconImageView.image = UIImage(named: imageName)
        iconImageView.contentMode = .scaleAspectFill
        
        let iconContainerView: UIView = UIView(frame: CGRect(x: 10, y: 0, width: 0, height: 0))
        iconContainerView.addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: iconContainerView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainerView.centerYAnchor)
        ])
        
        leftView = iconContainerView
        leftViewMode = .always
    }
}
