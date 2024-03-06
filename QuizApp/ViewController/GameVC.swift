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
        tabBarController?.tabBar.isHidden = true
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
        updateGroupButton()
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
        gameView.questionNumberOfCorrectAnswers.text = "Correct Answers: \(viewModel.questions[viewModel.questionIndex].correctAnswer.count)"
    }
    
    func updateGroupButton() {
        gameView.groupButtons.removeAll()
    }
    
    func updateAnswerButton() {
        for i in 0..<viewModel.questions[viewModel.questionIndex].answers.count {
            let button = gameView.answerButtons.setForArray(title: viewModel.questions[viewModel.questionIndex].answers[i].answerText, color: .black, tag: i)
            gameView.groupButtons.append(button)
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
    
    // MARK: - Next Question Handling
    
    func nextQuestion() {
        viewModel.prepareNextQuestion()
        
        if viewModel.questionIndex == viewModel.questions.count {
            let resultVC = ResultVC()
            resultVC.score = viewModel.score
            tabBarController?.tabBar.isHidden = false
            navigationController?.pushViewController(resultVC, animated: true)
        }
    }
}

// MARK: - GameViewDelegate

extension GameVC: GameViewDelegate {
    func didTapAnswer() {
        nextQuestion()
    }
}


// MARK: - Private extension

//private extension GameVC {
//    func updateUI() {
//        let currentQuestion = viewModel.questions[viewModel.questionIndex]
//        let currentAnswer = currentQuestion.answers
//        let totalProgress = Float(viewModel.questionIndex) / Float(viewModel.questions.count)
//
//        gameView.questionLbl.text = currentQuestion.questionName
//        gameView.questionNumberOfCorrectAnwersLbl.text = "Correct answers: \(currentQuestion.numberOfCorrectAnswers)"
//        gameView.progressVw.setProgress(totalProgress, animated: true)
//
//        switch currentQuestion.type {
//        case .single:
//            updateSingleStack(using: currentAnswer)
//        case .multiple:
//            updateSingleStack(using: currentAnswer)
//        }
//
//        if viewModel.questionIndex == viewModel.questions.count - 1 {
//            gameView.nextBtn.configuration = .quiz(with: .init(title: "finish", backgroundColorHex: "#f0942b", titleColorHex: "#000000"))
//        } else {
//            gameView.nextBtn.configuration = .quiz(with: .init(title: "next", backgroundColorHex: "#f0942b", titleColorHex: "#000000"))
//        }
//
//        gameView.nextBtn.isHidden = true
//    }
//
//    func updateSingleStack(using answers: [Answers]) {
//        gameView.singleBtn1.configuration = .quiz(with: .init(title: answers[0].answerText))
//        gameView.singleBtn2.configuration = .quiz(with: .init(title: answers[1].answerText))
//        gameView.singleBtn3.configuration = .quiz(with: .init(title: answers[2].answerText))
//        gameView.singleBtn4.configuration = .quiz(with: .init(title: answers[3].answerText))
//    }
//
//    func nextQuestion() {
//        viewModel.answerChoosen.removeAll()
//        viewModel.questionIndex += 1
//        viewModel.score += 1
//        viewModel.count = 0
//
//        if viewModel.questionIndex < viewModel.questions.count {
//            updateUI()
//        } else {
//            tabBarController?.tabBar.isHidden = false
//            navigationController?.popViewController(animated: true)
//        }
//    }
//
//    func showResults() {
//        let currentAnswers = viewModel.questions[viewModel.questionIndex].answers
//        let correct = viewModel.questions[viewModel.questionIndex].correctAnswer
//        countTapNext += 1
//
//        if countTapNext == 2 {
//            countTapNext = 0
//            nextQuestion()
//        } else {
//            gameView.singleBtn1.configuration = .quiz(with: .init(title: currentAnswers[0].answerText, backgroundColorHex: correct.contains(currentAnswers[0].answerText) ? "#2bd60d" : "#000000", titleColorHex: "#ffffff"))
//            gameView.singleBtn2.configuration = .quiz(with: .init(title: currentAnswers[1].answerText, backgroundColorHex: correct.contains(currentAnswers[1].answerText) ? "#2bd60d" : "#000000", titleColorHex: "#ffffff"))
//            gameView.singleBtn3.configuration = .quiz(with: .init(title: currentAnswers[2].answerText, backgroundColorHex: correct.contains(currentAnswers[2].answerText) ? "#2bd60d" : "#000000", titleColorHex: "#ffffff"))
//            gameView.singleBtn4.configuration = .quiz(with: .init(title: currentAnswers[3].answerText, backgroundColorHex: correct.contains(currentAnswers[3].answerText) ? "#2bd60d" : "#000000", titleColorHex: "#ffffff"))
//        }
//    }
//
//    func removeFromUserAnswer (currentAnswer: String) {
//        viewModel.count -= 1
//
//        if viewModel.count < viewModel.questions[viewModel.questionIndex].numberOfCorrectAnswers {
//            gameView.nextBtn.isHidden = true
//        }
//
//        if let index = viewModel.answerChoosen.firstIndex(of: currentAnswer) {
//            viewModel.answerChoosen.remove(at: index)
//        }
//
//        if viewModel.answerChoosen.isEmpty {
//            gameView.nextBtn.isHidden = true
//        }
//    }
//
//    func validateAnswers(currentAnswer: String) {
//        viewModel.count += 1
//        var correctAnswers = viewModel.questions[viewModel.questionIndex].correctAnswer
//        viewModel.answerChoosen.append(currentAnswer)
//        viewModel.answerChoosen.sort()
//        correctAnswers.sort()
//
//        if viewModel.count == viewModel.questions[viewModel.questionIndex].numberOfCorrectAnswers {
//            gameView.nextBtn.isHidden = false
//        }
//
//        if viewModel.answerChoosen.contains(correctAnswers) {
//
//            gameView.nextBtn.isHidden = false
//        }
//    }
//
//    @objc func didTapAnswer(_ sender: UIButton) {
//        let currentAnswers = viewModel.questions[viewModel.questionIndex].answers
//
//        switch sender.tag {
//        case 0:
//            gameView.singleBtn1.isSelected = !sender.isSelected
//            gameView.singleBtn1.configuration = .quiz(with: .init(title: currentAnswers[sender.tag].answerText, backgroundColorHex: sender.isSelected ? "#00bbff" : "#000000", titleColorHex: sender.isSelected ? "#ffffff" : "ffffff"))
//            gameView.singleBtn1.isSelected ? validateAnswers(currentAnswer: currentAnswers[sender.tag].answerText) : removeFromUserAnswer(currentAnswer: currentAnswers[sender.tag].answerText)
//        case 1:
//            gameView.singleBtn2.isSelected = !sender.isSelected
//            gameView.singleBtn2.configuration = .quiz(with: .init(title: currentAnswers[sender.tag].answerText, backgroundColorHex: sender.isSelected ? "#00bbff" : "#000000", titleColorHex: sender.isSelected ? "#ffffff" : "ffffff"))
//            gameView.singleBtn2.isSelected ? validateAnswers(currentAnswer: currentAnswers[sender.tag].answerText) : removeFromUserAnswer(currentAnswer: currentAnswers[sender.tag].answerText)
//
//        case 2:
//            gameView.singleBtn3.isSelected = !sender.isSelected
//            gameView.singleBtn3.configuration = .quiz(with: .init(title: currentAnswers[sender.tag].answerText, backgroundColorHex: sender.isSelected ? "#00bbff" : "#000000", titleColorHex: sender.isSelected ? "#ffffff" : "ffffff"))
//            gameView.singleBtn3.isSelected ? validateAnswers(currentAnswer: currentAnswers[sender.tag].answerText) : removeFromUserAnswer(currentAnswer: currentAnswers[sender.tag].answerText)
//        case 3:
//            gameView.singleBtn4.isSelected = !sender.isSelected
//            gameView.singleBtn4.configuration = .quiz(with: .init(title: currentAnswers[sender.tag].answerText, backgroundColorHex: sender.isSelected ? "#00bbff" : "#000000", titleColorHex: sender.isSelected ? "#ffffff" : "ffffff"))
//            gameView.singleBtn4.isSelected ? validateAnswers(currentAnswer: currentAnswers[sender.tag].answerText) : removeFromUserAnswer(currentAnswer: currentAnswers[sender.tag].answerText)
//        default:
//            break
//        }
//    }
//
//    @objc func didTapNext() {
//        gameView.singleBtn1.isSelected = false
//        gameView.singleBtn2.isSelected = false
//        gameView.singleBtn3.isSelected = false
//        gameView.singleBtn4.isSelected = false
//        showResults()
//    }
//
//}
