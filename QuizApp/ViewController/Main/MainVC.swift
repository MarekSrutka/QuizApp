//
//  MainVC.swift
//  QuizApp
//
//  Created by Marek Srutka on 21.02.2024.
//

import UIKit


class MainVC: UIViewController {
    
    let easyToUse = EasyToUse()
    
    
// MARK: - Properties
    
    private lazy var mainVw: MainView = {
        let vw = MainView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}


// MARK: = Private extension

private extension MainVC {
    
    // MARK: - Setup UI
    
    func setupUI() {
        
        easyToUse.setGradientBackground(self.view)
        self.view.addSubview(mainVw)
        
        NSLayoutConstraint.activate([
            mainVw.topAnchor.constraint(equalTo: self.view.topAnchor),
            mainVw.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            mainVw.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mainVw.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}
