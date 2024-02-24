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
    let title: String
    let question1: String
    let question2: String
    let question3: String
    let question4: String
    let correctAnswer: [String]
}
