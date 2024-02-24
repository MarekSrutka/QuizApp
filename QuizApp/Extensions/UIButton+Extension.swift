//
//  UIButton+Extension.swift
//  QuizApp
//
//  Created by Marek Srutka on 24.02.2024.
//

import UIKit

extension UIButton.Configuration {
    
    static func primary(with model: ButtonSetup) -> Self {
        var config = UIButton.Configuration.filled()
        var container = AttributeContainer()
        let originImage = UIImage(named: model.iconName ?? "")?.withTintColor(UIColor(hex: model.iconColorHex ?? "#ffffff", alpha: 1.0)!)
        
        container.font = UIFont.boldSystemFont(ofSize: 20)
        
        config.attributedTitle = AttributedString(model.title.uppercased(), attributes: container)
        config.baseBackgroundColor = UIColor(hex: model.backgroundColorHex ?? "#000000", alpha: 0.0)
        config.baseForegroundColor = UIColor(hex: model.titleColorHex ?? "#ffffff", alpha: 1.0)
        config.image = originImage?.scale(newWidth: 20)
        config.imagePadding = 8
        config.buttonSize = .large
        config.cornerStyle = .medium
        
        return config
    }
    
}
