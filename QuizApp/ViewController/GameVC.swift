//
//  GameVC.swift
//  QuizApp
//
//  Created by Marek Srutka on 24.02.2024.
//

import UIKit
import Combine

class GameVC: UIViewController {
    
    // MARK: - Properties
    
    private let mockServices = QuestionMock()
    private lazy var viewModel = QuestionViewModel(service: mockServices.self)
    private var cancellables: Set<AnyCancellable> = []
    
    var gameView = GameView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCombine()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        #warning("for testing")
//        tabBarController?.tabBar.isHidden = true
    }
    
    deinit {
        print("Instance of class GameVC has been deallocated.")
        cancellables.forEach { $0.cancel() }
    }
    
    // MARK: - UI Setup
    
    func setupUI() {
        configureControllerView()
        configureGameView()
    }
    
    func updateGameView() {
        updateProgressView()
        updateTitleLabel()
        updateQustionNumberOfCorrectAnswers()
        updateAnswerButton()
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
    
    func updateProgressView() {
        let totalProgress = Float(viewModel.questionIndex) / Float(viewModel.questions.count)
        gameView.progressView.setProgress(totalProgress, animated: true)
    }
    
    func updateTitleLabel() {
        gameView.questionTitle.text = "\(viewModel.questions[viewModel.questionIndex].questionName)"
    }
    
    func updateQustionNumberOfCorrectAnswers() {
        gameView.questionNumberOfCorrectAnswers.text = "\("GAME_CORRECT_ANS".localized) \(viewModel.questions[viewModel.questionIndex].correctAnswer.count)"
    }
    
    func updateAnswerButton() {
        for i in 0..<viewModel.questions[viewModel.questionIndex].answers.count {
            let answerText = viewModel.questions[viewModel.questionIndex].answers[i].answerText
            
            let button = gameView.answerButtons.setForArray(title: answerText, color: .black, tag: i)
            
            if let existingButton = gameView.groupButtons.first(where: { $0.tag == i }) {
                existingButton.set(title: answerText, color: .black, tag: i)
            } else {
                gameView.groupButtons.append(button)
            }
        }
        
        DispatchQueue.main.async {
            self.gameView.configureAnswerButton()
        }
    }
    
    // MARK: - Combine Setup
    
    private func setupCombine() {
        viewModel.$questionIndex
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self, self.viewModel.questionIndex < self.viewModel.questions.count else {
                    return
                }
                self.updateGameView()
            }
            .store(in: &cancellables)
    }
    
    func preparePushNextMove() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.gameView.groupButtons.forEach { button in
                button.set(title: button.titleLabel?.text ?? "", color: .black, tag: button.tag)
                button.isSelected = false
            }
            
            self.gameView.groupButtons.forEach { $0.isUserInteractionEnabled = true }
            
            self.viewModel.answerChoosen.removeAll()
            self.nextQuestion()
        }
    }
    
    func selectButton(at index: Int) {
        guard index < gameView.groupButtons.count else {
            return
        }
        
        let selectedButton = gameView.groupButtons[index]
        let selectedAnswer = viewModel.questions[viewModel.questionIndex].answers[index].answerText
        
        //        let isSelected = selectedButton.isSelected -- MARK: -FIX:
        selectedButton.isSelected = true
        
        let isCorrectAnswer = viewModel.questions[viewModel.questionIndex].correctAnswer.contains(selectedAnswer)
        
        
        //      MARK: -FIX: ready for selected and unselected ... Need for showing right answers --later
        if selectedButton.isSelected {
            viewModel.addToAnswerChoosen(selectedAnswer)
            selectedButton.set(title: selectedAnswer, color: isCorrectAnswer ? .green : .red, tag: index)
        } else {
            viewModel.deleteFromAnswerChoosen(selectedAnswer)
            selectedButton.set(title: selectedAnswer, color: .black, tag: index)
        }
        
        let selectedAnswersCount = gameView.groupButtons.filter { $0.isSelected }.count
        gameView.groupButtons.forEach { $0.isUserInteractionEnabled = selectedAnswersCount < viewModel.questions[viewModel.questionIndex].correctAnswer.count }
        
        if selectedAnswersCount == viewModel.questions[viewModel.questionIndex].correctAnswer.count {
            viewModel.increaseScoreOrNot()
            
            preparePushNextMove()
        }
    }
    
    func displayResultVC() {
        let resultVC = ResultVC()
        resultVC.score = viewModel.score
        resultVC.reachScore = viewModel.questions.count
        tabBarController?.tabBar.isHidden = false
        navigationController?.pushViewController(resultVC, animated: true)
    }
    
    // MARK: - Next Question Handling
    
    func nextQuestion() {
        viewModel.prepareNextQuestion()
        
        if viewModel.questionIndex == viewModel.questions.count {
            displayResultVC()
        }
    }
}

// MARK: - GameViewDelegate

extension GameVC: GameViewDelegate {
    func didTapAnswer(at index: Int) {
        selectButton(at: index)
    }
}
