//
//  String+Extension.swift
//  QuizApp
//
//  Created by Marek Srutka on 06.03.2024.
//

import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
