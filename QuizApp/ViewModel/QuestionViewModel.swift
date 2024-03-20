//
//  QuestionViewModel.swift
//  QuizApp
//
//  Created by Marek Srutka on 22.02.2024.
//

import Foundation
import Combine

class QuestionViewModel: ObservableObject {
    @Published var questions: [QuestionResponse] = []
    @Published var questionIndex: Int = 0
    var error: Error? = nil
    var answerChoosen: [String] = []
    var score: Int = 0
    
    private let service: QuestionService
    
    init(service: QuestionService) {
        self.service = service
        fetchData()
    }
    
    func fetchData() {
        service.getQuestions { [weak self] result in
            switch result {
            case .success(let questionResponse):
                self?.questions = questionResponse.data
            case .failure(let error):
                self?.error = error
            }
        }
    }
    
    func addToAnswerChoosen(_ selectedAnswer: String) {
        answerChoosen.append(selectedAnswer)
    }
    
    func deleteFromAnswerChoosen(_ selectedAnswer: String) {
        if let indexToRemove = answerChoosen.firstIndex(of: selectedAnswer) {
            answerChoosen.remove(at: indexToRemove)
        }
    }
    
    func prepareNextQuestion() {
        answerChoosen.removeAll()
        questionIndex += 1
    }
    
    func increaseScoreOrNot() {
        let areAnswersCorrect = Set(answerChoosen).isSuperset(of: questions[questionIndex].correctAnswer)
        if areAnswersCorrect {
            score += 1
        }
    }
}
