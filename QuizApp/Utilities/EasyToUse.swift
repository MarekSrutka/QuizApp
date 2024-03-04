//
//  EasyToUse.swift
//  QuizApp
//
//  Created by Marek Srutka on 23.02.2024.
//

import UIKit

enum EasyToUse {
    static func setGradientBackground(_ view: UIView, colorTop: ColorType, colorBottom: ColorType) {
        let colorTop =  UIColor(red: colorTop.red/255.0, green: colorTop.green/255.0, blue: colorTop.blue/255.0, alpha: colorTop.alpha).cgColor
        let colorBottom = UIColor(red: colorBottom.red/255.0, green: colorBottom.green/255.0, blue: colorBottom.blue/255.0, alpha: colorBottom.alpha).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
                
        view.layer.insertSublayer(gradientLayer, at:0)
    }
}

struct ColorType {
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var alpha: CGFloat
}
