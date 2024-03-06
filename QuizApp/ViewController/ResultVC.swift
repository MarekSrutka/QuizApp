//
//  ResultVC.swift
//  QuizApp
//
//  Created by Marek Srutka on 06.03.2024.
//

import UIKit

class ResultVC: UIViewController {
    
    var score: Int!
    var reachScore: Int!
    
    var resultView = ResultView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        configureViewController()
        configureResultView()
    }
    
    func configureViewController() {
        EasyToUse.setGradientBackground(view, colorTop: ColorGradient.topColor, colorBottom: ColorGradient.bottomColor)
    }
    
    func configureResultView() {
        view.addSubview(resultView)
        
        guard score != nil, reachScore != nil else {
            return
        }
        
        resultView.scoreLabel.text = String("\(score!)/\(reachScore!)")
        
        NSLayoutConstraint.activate([
            resultView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            resultView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            resultView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
