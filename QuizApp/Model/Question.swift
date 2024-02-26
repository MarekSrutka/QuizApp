//
//  Question.swift
//  QuizApp
//
//  Created by Marek Srutka on 22.02.2024.
//

import Foundation

struct Question: Codable {
    let data: [QuestionResponse]
}

struct QuestionResponse: Codable {
    let questionName: String
    let answers: [Answers]
    let correctAnswer: [String]
    let numberOfCorrectAnswers: Int
    let type: QuestionType
}

struct Answers: Codable {
    let answerText: String
}
