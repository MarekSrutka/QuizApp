//
//  QuizAppTests.swift
//  QuizAppTests
//
//  Created by Marek Srutka on 21.02.2024.
//

import XCTest
@testable import QuizApp

final class QuizAppTests: XCTestCase {

    func testQuestionViewModel() {
        let mockedService = QuestionMock()
        let viewModel = QuestionViewModel(service: mockedService)
        
        viewModel.fetchData()
        
        XCTAssertEqual(viewModel.questions.count, 3)
    }

}
