//
//  QAButton.swift
//  QuizApp
//
//  Created by Marek Srutka on 02.03.2024.
//

import UIKit

class QAButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, color: UIColor) {
        self.init(frame: .zero)
        set(title: title, color: color)
    }
    
    private func configure() {
        configuration = .filled()
        configuration?.cornerStyle = .medium
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    final func set(title: String, color: UIColor) {
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = .white
        
        configuration?.title = title
    }
}

