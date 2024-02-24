//
//  MainView.swift
//  QuizApp
//
//  Created by Marek Srutka on 23.02.2024.
//

import UIKit

class MainView: UIView {

// MARK: - Properties
    
    let headerVw: HeaderView = {
       
        let vw = HeaderView("Welcome home 👋")
        
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        return vw
    }()
    
    
// MARK: - Init
        
        init() {
            super.init(frame: .zero)
            
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}


// MARK: = Private extension

private extension MainView {
    
// MARK: - SetupUI
    
    func setupUI() {
        
        self.addSubview(headerVw)
        
        NSLayoutConstraint.activate([
            headerVw.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            headerVw.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            headerVw.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
}
