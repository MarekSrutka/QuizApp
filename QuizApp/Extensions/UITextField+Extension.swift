//
//  UITextField+Extension.swift
//  QuizApp
//
//  Created by Marek Srutka on 23.02.2024.
//

import UIKit

extension UITextField {
    func imageSetup(imageName: String) {
        let imageView = UIImageView(frame: CGRect(x: 15, y: 13, width: 25, height: 25))
        imageView.image = UIImage(named: imageName)
        let imageContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageContainerView.addSubview(imageView)
        leftView = imageContainerView
        leftViewMode = .always
        self.tintColor = .black
    }
}
