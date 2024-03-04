//
//  GameVC.swift
//  QuizApp
//
//  Created by Marek Srutka on 24.02.2024.
//

import UIKit

class GameVC: UIViewController {
    
    private let mockServices = QuestionMock()
    var gameView: GameView!

    override func viewDidLoad() {
        super.viewDidLoad()
        gameView = GameView(mockService: mockServices)
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    func setupUI() {
        configureControllerView()
        configureGameView()
    }
    
    func configureControllerView() {
        EasyToUse.setGradientBackground(view, colorTop: ColorGradient.topColor, colorBottom: ColorGradient.bottomColor)
    }
    
    func configureGameView() {
        view.addSubview(gameView)
        gameView.delegate = self
        NSLayoutConstraint.activate([
            gameView.topAnchor.constraint(equalTo: view.topAnchor),
            gameView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gameView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func updateViewModel() {
        gameView.viewModel.answerChoosen.removeAll()
        gameView.viewModel.questionIndex += 1
        gameView.viewModel.score += 1
        gameView.viewModel.count = 0
    }
    
    func nextQuestion() {
        updateViewModel()
        if gameView.viewModel.questionIndex == gameView.viewModel.questions.count {
            tabBarController?.tabBar.isHidden = false
            navigationController?.popViewController(animated: true)
        }
    }
}

extension GameVC: GameViewDelegate {
    func didTapAnswer() {
        nextQuestion()
    }
}
