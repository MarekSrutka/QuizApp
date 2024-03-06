//
//  QAPlayButton.swift
//  QuizApp
//
//  Created by Marek Srutka on 02.03.2024.
//

import UIKit

class QAPlayButton: UIButton {

    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(icon: UIImage) {
        self.init(frame: .zero)
        set(icon: icon)
    }
    
    // MARK: - Configuration
    
    private func configure() {
        backgroundColor = UIColor(hex: "#23d602", alpha: 1.0)
        layer.cornerRadius = 30
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 4, height: 4)
    }
    
    final func set(icon: UIImage) {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .large)
        setImage(icon.withConfiguration(largeConfig).withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
    }
}
