//
//  SettingsVC.swift
//  QuizApp
//
//  Created by Marek Srutka on 23.02.2024.
//

import UIKit

class SettingsVC: UIViewController {
    
   private let easyToUse = EasyToUse()
    
    
// MARK: - Properties
    
    private lazy var settingsVw: SettingsView = {
        let vw = SettingsView { [weak self] in
            self?.clickLogout()
        }
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}


// MARK: - Private extension

extension SettingsVC {
    
// MARK: - SetupUI
    
    func setupUI() {
        
        easyToUse.setGradientBackground(self.view,
                                        colorTop: .init(
                                            red: 255.0,
                                            green: 149.0,
                                            blue: 0.0,
                                            alpha: 1.0
                                        ),
                                        colorBottom: .init(
                                            red: 255.0,
                                            green: 94.0,
                                            blue: 58.0,
                                            alpha: 1.0
                                        )
        )
        self.view.addSubview(settingsVw)
        
        NSLayoutConstraint.activate([
            settingsVw.topAnchor.constraint(equalTo: self.view.topAnchor),
            settingsVw.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            settingsVw.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            settingsVw.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    
// MARK: - Functions
    
    func clickLogout() {
        easyToUse.defaults.setValue(nil, forKey: "username")
        easyToUse.defaults.removeObject(forKey: "username")
        dismiss(animated: false)
    }
}
