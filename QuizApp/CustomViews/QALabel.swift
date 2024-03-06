//
//  QALabel.swift
//  QuizApp
//
//  Created by Marek Srutka on 03.03.2024.
//

import UIKit

class QALabel: UILabel {

    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat, weight: UIFont.Weight, textColor: UIColor? = nil) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        self.textColor = textColor ?? .black
    }
    
    func set(title: String? = nil,
             textAlignment: NSTextAlignment,
             fontSize: CGFloat = 18,
             weight: UIFont.Weight = .regular,
             textColor: UIColor = .black,
             numberOfLines: Int = 1
    ) {
        self.textAlignment = textAlignment
        self.text = title
        self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        self.textColor = textColor
        self.numberOfLines = numberOfLines
        
        configure()
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
