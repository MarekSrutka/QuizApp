//
//  SettingsVC.swift
//  QuizApp
//
//  Created by Marek Srutka on 23.02.2024.
//

import UIKit

class SettingsVC: UIViewController {
    
    // MARK: - Properties
    
    let settingsView = SettingsView()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - UI Setup
    
    func setupUI() {
        configureViewController()
        configureSettingsView()
    }
    
    func configureViewController() {
        EasyToUse.setGradientBackground(view, colorTop: ColorGradient.topColor, colorBottom: ColorGradient.bottomColor)
    }
    
    func configureSettingsView() {
        view.addSubview(settingsView)
        settingsView.delegate = self
        
        NSLayoutConstraint.activate([
            settingsView.topAnchor.constraint(equalTo: view.topAnchor),
            settingsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            settingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - Logout Handling
    
    func clickLogout() {
        PersistanceManager.deleteUser()
        dismiss(animated: false)
    }
    
}

// MARK: - SettingsViewDelegate

extension SettingsVC: SettingsViewDelegate {
    func didTapLogout() {
        clickLogout()
    }
}
