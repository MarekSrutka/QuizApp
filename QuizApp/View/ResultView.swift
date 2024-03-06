//
//  ResultView.swift
//  QuizApp
//
//  Created by Marek Srutka on 06.03.2024.
//

import UIKit

class ResultView: UIView {
    
    // MARK: - Properties
    
    var scoreLabel = QALabel(textAlignment: .center, fontSize: 26, weight: .bold)
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Configuration
    
    private func setup() {
        configureScoreLabel()
    }
    
    private func configureScoreLabel() {
        addSubview(scoreLabel)
        
        NSLayoutConstraint.activate([
            scoreLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            scoreLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

}
