//
//  QuestionViewModel.swift
//  QuizApp
//
//  Created by Marek Srutka on 22.02.2024.
//

import Foundation
import Combine

class QuestionViewModel: ObservableObject {
    var questions: [QuestionResponse] = []
    var error: Error? = nil
    @Published var questionIndex: Int = 0
    var answerChoosen: [String] = []
    var score: Int = 0
    var count: Int = 0
    
    private let service: QuestionServicing
    
    init(service: QuestionServicing) {
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
}
