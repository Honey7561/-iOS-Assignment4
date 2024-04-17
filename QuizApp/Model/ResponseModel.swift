//
//  ResponseModel.swift
//  BoilerPlate
//
//  Created by user238851 on 13/04/24.
//

import Foundation

// MARK: - ResponseModel
struct ResponseModel: Codable {
    let responseCode: Int?
    let results: [ResultModel]?

    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results
    }
}

// MARK: - Result
struct ResultModel: Codable {
    let type: String?
    let difficulty: String?
    let category: String?
    let question: String?
    let correctAnswer: String?
    let incorrectAnswers: [String]?

    enum CodingKeys: String, CodingKey {
        case type, difficulty, category, question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}
