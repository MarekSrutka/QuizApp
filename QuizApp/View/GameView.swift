//
//  GameView.swift
//  QuizApp
//
//  Created by Marek Srutka on 24.02.2024.
//

import UIKit
import Combine

protocol GameViewDelegate: AnyObject {
    func didTapAnswer()
}

class GameView: UIView {
    
    var viewModel: QuestionViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Properties
    
    let questionTitle = QALabel(textAlignment: .center, fontSize: 24, weight: .bold)
    let questionNumberOfCorrenctAnswers = QALabel(textAlignment: .center, fontSize: 12, weight: .medium)
    let progressView = UIProgressView()
    let stackView = UIStackView()
    var answerButtons = QAButton()
    var groupButtons: [QAButton] = []
    let nextButton = QAButton()
    
    weak var delegate: GameViewDelegate?
    
    init(mockService: QuestionMock) {
        self.viewModel = QuestionViewModel(service: mockService)
        super.init(frame: .zero)
        setupUI()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCombine() {
        viewModel.$questionIndex
            .sink { [weak self] _ in
                self?.updateUI()
            }
            .store(in: &cancellables)
    }
    
    private func setupUI() {
        configureProgressView()
        configureQuestionTitle()
        configureQuestionNumber()
        configureAnswerButton()
        configureStackView()
//        configureNextButton()
    }
    
    private func updateUI() {
        configureProgressView()
        configureQuestionTitle()
        configureQuestionNumber()
        groupButtons.removeAll()
        configureAnswerButton()
    }
    
    private func configureProgressView() {
        addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        let totalProgress = Float(viewModel.questionIndex) / Float(viewModel.questions.count)
        progressView.setProgress(totalProgress, animated: true)
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            progressView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            progressView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
    }
    
    private func configureQuestionTitle() {
        addSubview(questionTitle)
        
        let questionName = viewModel.questions[viewModel.questionIndex]
        questionTitle.set(title: questionName.questionName, textAlignment: .center, fontSize: 24, weight: .bold, numberOfLines: 0)
        
        NSLayoutConstraint.activate([
            questionTitle.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 10),
            questionTitle.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            questionTitle.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            questionTitle.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    private func configureQuestionNumber() {
        addSubview(questionNumberOfCorrenctAnswers)
        
        let questionNumber = viewModel.questions[viewModel.questionIndex].correctAnswer.count
        
        questionNumberOfCorrenctAnswers.set(title: "CorrenctAnswers: \(questionNumber)",
                                            textAlignment: .center,
                                            fontSize: 14,
                                            weight: .bold)
        
        NSLayoutConstraint.activate([
            questionNumberOfCorrenctAnswers.topAnchor.constraint(equalTo: questionTitle.bottomAnchor, constant: 10),
            questionNumberOfCorrenctAnswers.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            questionNumberOfCorrenctAnswers.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            questionNumberOfCorrenctAnswers.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func configureStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: questionNumberOfCorrenctAnswers.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
    }
    
    private func clearStackView() {
        stackView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    private func configureAnswerButton() {
        for i in 0..<viewModel.questions[viewModel.questionIndex].answers.count {
            let button = answerButtons.setForArray(title: viewModel.questions[viewModel.questionIndex].answers[i].answerText, color: .black, tag: i)
            button.addTarget(self, action: #selector(didTapAnwer), for: .touchUpInside)
            groupButtons.append(button)
        }
        
        for button in groupButtons {
            stackView.addArrangedSubview(button)
            
            
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
                button.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
                button.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
    }
    
    private func configureNextButton() {
        addSubview(nextButton)
        
        nextButton.set(title: "Next", color: .brown)
        
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            nextButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func didTapAnwer() {
        delegate?.didTapAnswer()
        clearStackView()
        if viewModel.questionIndex < viewModel.questions.count {
            setupCombine()
        }
    }
}
