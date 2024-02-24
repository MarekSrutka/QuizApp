//
//  SettingsViewController.swift
//  QuizApp
//
//  Created by Marek Srutka on 23.02.2024.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let easyToUse = EasyToUse()
    
    
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

extension SettingsViewController {
    
// MARK: - SetupUI
    
    func setupUI() {
        
        easyToUse.setGradientBackground(self.view)
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
        easyToUse.defaults.removeObject(forKey: "username")
        dismiss(animated: false)
    }
}
