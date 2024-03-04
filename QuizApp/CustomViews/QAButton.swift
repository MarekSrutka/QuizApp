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
    
    convenience init(title: String, color: UIColor, tag: Int = 1) {
        self.init(frame: .zero)
        set(title: title, color: color, tag: tag)
    }
    
    private func configure() {
        configuration = .filled()
        configuration?.cornerStyle = .medium
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    final func set(title: String, color: UIColor, tag: Int = 1) {
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = .white
        configuration?.title = title
        
        self.tag = tag
    }
}

extension QAButton {
    func setForArray(title: String, color: UIColor, tag: Int) -> QAButton {
        let button = QAButton()
        button.set(title: title, color: color, tag: tag)
        return button
    }
}

