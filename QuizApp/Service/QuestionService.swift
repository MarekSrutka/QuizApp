//
//  QuestionService.swift
//  QuizApp
//
//  Created by Marek Srutka on 26.02.2024.
//

import Foundation
import FirebaseDatabase

protocol QuestionServicing {
    func getQuestions(_ completion: @escaping (Result<Question, Error>) -> Void)
}

class QuestionService: QuestionServicing {
    func getQuestions(_ completion: @escaping (Result<Question, Error>) -> Void) {
        let database = Database.database().reference()
        let url = URL(string: "\(database.url)/.json")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else {
                if let error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NetworkError.noData))
                }
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(Question.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    enum NetworkError: Error {
        case noData
    }
}

// MARK: - Questions Mock

class QuestionMock: QuestionServicing {
    func getQuestions(_ completion: @escaping (Result<Question, Error>) -> Void) {
        let response = Question(data: [
            QuestionResponse(
                questionName: "Who are we fighting against in Assassin's Creed 2?",
                answers: [
                    Answers(answerText: "BlackSun"),
                    Answers(answerText: "Sage of the Cult of Kosmos"),
                    Answers(answerText: "Templars"),
                    Answers(answerText: "Origins")
                ],
                correctAnswer: ["Templars"],
                numberOfCorrectAnswers: 1,
                type: .single
            ),
            QuestionResponse(
                questionName: "At the beginning of Need For Speed Most Wanted 2005 we have what kind of car",
                answers: [
                    Answers(answerText: "Porsche GT2"),
                    Answers(answerText: "BMW M3 GTR"),
                    Answers(answerText: "Aston Martin DB9"),
                    Answers(answerText: "VW Golf")
                ],
                correctAnswer: ["BMW M3 GTR"],
                numberOfCorrectAnswers: 1,
                type: .single
            ),
            QuestionResponse(
                questionName: "There are 3 main protagonist in GTA 5, what are their names",
                answers: [
                    Answers(answerText: "Michael De Santa"),
                    Answers(answerText: "Trevor Philips"),
                    Answers(answerText: "Devin Weston"),
                    Answers(answerText: "Franklin Clinton")
                ],
                correctAnswer: ["Michael De Santa", "Trevor Philips", "Franklin Clinton"],
                numberOfCorrectAnswers: 3,
                type: .multiple
            ),
            QuestionResponse(
                questionName: "What weapon you cannot use in Metro 2023",
                answers: [
                    Answers(answerText: "Bastard"),
                    Answers(answerText: "Revolver"),
                    Answers(answerText: "Preved"),
                    Answers(answerText: "Kalash")
                ],
                correctAnswer: ["Preved"],
                numberOfCorrectAnswers: 1,
                type: .single
            ),
            QuestionResponse(
                questionName: "What games can you play in co-op?",
                answers: [
                    Answers(answerText: "It Takes Two"),
                    Answers(answerText: "Sackboy"),
                    Answers(answerText: "Battlefied 3"),
                    Answers(answerText: "Call of Duty 2")
                ],
                correctAnswer: ["It Takes Two", "Sackboy", ],
                numberOfCorrectAnswers: 2,
                type: .multiple
            ),
            QuestionResponse(
                questionName: "What nations can you play as in the strategy game Company of Heroes 2",
                answers: [
                    Answers(answerText: "USA"),
                    Answers(answerText: "Poland"),
                    Answers(answerText: "Italy"),
                    Answers(answerText: "SSSR")
                ],
                correctAnswer: ["USA", "SSSR"],
                numberOfCorrectAnswers: 2,
                type: .multiple
            ),
            QuestionResponse(
                questionName: "What genre the sims 4",
                answers: [
                    Answers(answerText: "First person shooter"),
                    Answers(answerText: "Third person shooter"),
                    Answers(answerText: "Life simulator"),
                    Answers(answerText: "Racing simulator")
                ],
                correctAnswer: ["Life simulator"],
                numberOfCorrectAnswers: 1,
                type: .single
            ),
            QuestionResponse(
                questionName: "On which platform we can play Into the Radius",
                answers: [
                    Answers(answerText: "MacOS"),
                    Answers(answerText: "WindowsOS"),
                    Answers(answerText: "VR"),
                    Answers(answerText: "LinuxOS")
                ],
                correctAnswer: ["VR"],
                numberOfCorrectAnswers: 1,
                type: .single
            ),
            QuestionResponse(
                questionName: "From what year can Hearts of Iron 4 start",
                answers: [
                    Answers(answerText: "1936"),
                    Answers(answerText: "1939"),
                    Answers(answerText: "1935"),
                    Answers(answerText: "1940")
                ],
                correctAnswer: ["1936", "1939"],
                numberOfCorrectAnswers: 2,
                type: .multiple
            ),
            QuestionResponse(
                questionName: "What is the name of the main character in the game Far Cry 3",
                answers: [
                    Answers(answerText: "Vaase"),
                    Answers(answerText: "Peter"),
                    Answers(answerText: "Colin"),
                    Answers(answerText: "Jason")
                ],
                correctAnswer: ["Jason"],
                numberOfCorrectAnswers: 1,
                type: .single
            ),
        ])
        
        completion(.success(response))
    }
}
