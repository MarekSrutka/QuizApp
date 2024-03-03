//
//  GameVC.swift
//  QuizApp
//
//  Created by Marek Srutka on 24.02.2024.
//

import UIKit

class GameVC: UIViewController {
    
// MARK: - Services
    
    #warning("change if you have real URL")
    private let mockServices = QuestionMock()
    
    private lazy var viewModel = QuestionViewModel(service: mockServices.self)
    
// MARK: - Properties
    
    private lazy var gameVw: GameView = {
        let vw = GameView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    var countTapNext: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        configuration()
        setupUI()
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
}


// MARK: - Private extension

private extension GameVC {
    
// MARK: = SetupUI
    
    func setupUI() {
        
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(gameVw)
        
        NSLayoutConstraint.activate([
            gameVw.topAnchor.constraint(equalTo: self.view.topAnchor),
            gameVw.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            gameVw.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            gameVw.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    func updateUI() {
        let currentQuestion = viewModel.questions[viewModel.questionIndex]
        let currentAnswer = currentQuestion.answers
        let totalProgress = Float(viewModel.questionIndex) / Float(viewModel.questions.count)
        
        gameVw.questionLbl.text = currentQuestion.questionName
        gameVw.questionNumberOfCorrectAnwersLbl.text = "Correct answers: \(currentQuestion.numberOfCorrectAnswers)"
        gameVw.progressVw.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswer)
        case .multiple:
            updateSingleStack(using: currentAnswer)
        }
        
        if viewModel.questionIndex == viewModel.questions.count - 1 {
            gameVw.nextBtn.configuration = .quiz(with: .init(title: "finish", backgroundColorHex: "#f0942b", titleColorHex: "#000000"))
        } else {
            gameVw.nextBtn.configuration = .quiz(with: .init(title: "next", backgroundColorHex: "#f0942b", titleColorHex: "#000000"))
        }
        
        gameVw.nextBtn.isHidden = true
    }
    
    func fetchData() {
        viewModel.fetchData()
    }
    
    func updateSingleStack(using answers: [Answers]) {
        gameVw.singleBtn1.configuration = .quiz(with: .init(title: answers[0].answerText))
        gameVw.singleBtn2.configuration = .quiz(with: .init(title: answers[1].answerText))
        gameVw.singleBtn3.configuration = .quiz(with: .init(title: answers[2].answerText))
        gameVw.singleBtn4.configuration = .quiz(with: .init(title: answers[3].answerText))
    }
    
    func nextQuestion() {
        viewModel.answerChoosen.removeAll()
        viewModel.questionIndex += 1
        viewModel.score += 1
        viewModel.count = 0
        
        if viewModel.questionIndex < viewModel.questions.count {
            updateUI()
        } else {
            tabBarController?.tabBar.isHidden = false
            navigationController?.popViewController(animated: true)
        }
    }
    
    func showResults() {
        let currentAnswers = viewModel.questions[viewModel.questionIndex].answers
        let correct = viewModel.questions[viewModel.questionIndex].correctAnswer
        countTapNext += 1
        
        if countTapNext == 2 {
            countTapNext = 0
            nextQuestion()
        } else {
            gameVw.singleBtn1.configuration = .quiz(with: .init(title: currentAnswers[0].answerText, backgroundColorHex: correct.contains(currentAnswers[0].answerText) ? "#2bd60d" : "#000000", titleColorHex: "#ffffff"))
            gameVw.singleBtn2.configuration = .quiz(with: .init(title: currentAnswers[1].answerText, backgroundColorHex: correct.contains(currentAnswers[1].answerText) ? "#2bd60d" : "#000000", titleColorHex: "#ffffff"))
            gameVw.singleBtn3.configuration = .quiz(with: .init(title: currentAnswers[2].answerText, backgroundColorHex: correct.contains(currentAnswers[2].answerText) ? "#2bd60d" : "#000000", titleColorHex: "#ffffff"))
            gameVw.singleBtn4.configuration = .quiz(with: .init(title: currentAnswers[3].answerText, backgroundColorHex: correct.contains(currentAnswers[3].answerText) ? "#2bd60d" : "#000000", titleColorHex: "#ffffff"))
        }
    }
    
    func configuration() {
        gameVw.singleBtn1.addTarget(self, action: #selector(didTapAnswer), for: .touchUpInside)
        gameVw.singleBtn2.addTarget(self, action: #selector(didTapAnswer), for: .touchUpInside)
        gameVw.singleBtn3.addTarget(self, action: #selector(didTapAnswer), for: .touchUpInside)
        gameVw.singleBtn4.addTarget(self, action: #selector(didTapAnswer), for: .touchUpInside)
        gameVw.nextBtn.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
    }
    
    func removeFromUserAnswer (currentAnswer: String) {
        viewModel.count -= 1
        
        if viewModel.count < viewModel.questions[viewModel.questionIndex].numberOfCorrectAnswers {
            gameVw.nextBtn.isHidden = true
        }
        
        if let index = viewModel.answerChoosen.firstIndex(of: currentAnswer) {
            viewModel.answerChoosen.remove(at: index)
        }
        
        if viewModel.answerChoosen.isEmpty {
            gameVw.nextBtn.isHidden = true
        }
    }
    
    func validateAnswers(currentAnswer: String) {
        viewModel.count += 1
        var correctAnswers = viewModel.questions[viewModel.questionIndex].correctAnswer
        viewModel.answerChoosen.append(currentAnswer)
        viewModel.answerChoosen.sort()
        correctAnswers.sort()
        
        if viewModel.count == viewModel.questions[viewModel.questionIndex].numberOfCorrectAnswers {
            gameVw.nextBtn.isHidden = false
        }
        
        if viewModel.answerChoosen.contains(correctAnswers) {
            
            gameVw.nextBtn.isHidden = false
        }
    }
    
    @objc func didTapAnswer(_ sender: UIButton) {
        let currentAnswers = viewModel.questions[viewModel.questionIndex].answers
        
        switch sender.tag {
        case 0:
            gameVw.singleBtn1.isSelected = !sender.isSelected
            gameVw.singleBtn1.configuration = .quiz(with: .init(title: currentAnswers[sender.tag].answerText, backgroundColorHex: sender.isSelected ? "#00bbff" : "#000000", titleColorHex: sender.isSelected ? "#ffffff" : "ffffff"))
            gameVw.singleBtn1.isSelected ? validateAnswers(currentAnswer: currentAnswers[sender.tag].answerText) : removeFromUserAnswer(currentAnswer: currentAnswers[sender.tag].answerText)
        case 1:
            gameVw.singleBtn2.isSelected = !sender.isSelected
            gameVw.singleBtn2.configuration = .quiz(with: .init(title: currentAnswers[sender.tag].answerText, backgroundColorHex: sender.isSelected ? "#00bbff" : "#000000", titleColorHex: sender.isSelected ? "#ffffff" : "ffffff"))
            gameVw.singleBtn2.isSelected ? validateAnswers(currentAnswer: currentAnswers[sender.tag].answerText) : removeFromUserAnswer(currentAnswer: currentAnswers[sender.tag].answerText)
            
        case 2:
            gameVw.singleBtn3.isSelected = !sender.isSelected
            gameVw.singleBtn3.configuration = .quiz(with: .init(title: currentAnswers[sender.tag].answerText, backgroundColorHex: sender.isSelected ? "#00bbff" : "#000000", titleColorHex: sender.isSelected ? "#ffffff" : "ffffff"))
            gameVw.singleBtn3.isSelected ? validateAnswers(currentAnswer: currentAnswers[sender.tag].answerText) : removeFromUserAnswer(currentAnswer: currentAnswers[sender.tag].answerText)
        case 3:
            gameVw.singleBtn4.isSelected = !sender.isSelected
            gameVw.singleBtn4.configuration = .quiz(with: .init(title: currentAnswers[sender.tag].answerText, backgroundColorHex: sender.isSelected ? "#00bbff" : "#000000", titleColorHex: sender.isSelected ? "#ffffff" : "ffffff"))
            gameVw.singleBtn4.isSelected ? validateAnswers(currentAnswer: currentAnswers[sender.tag].answerText) : removeFromUserAnswer(currentAnswer: currentAnswers[sender.tag].answerText)
        default:
            break
        }
    }
    
    @objc func didTapNext() {
        gameVw.singleBtn1.isSelected = false
        gameVw.singleBtn2.isSelected = false
        gameVw.singleBtn3.isSelected = false
        gameVw.singleBtn4.isSelected = false
        showResults()
    }
    
}
