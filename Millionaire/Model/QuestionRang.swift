//
//  QuestionRang.swift
//  Millionaire
//
//  Created by Варвара Уткина on 22.07.2025.
//

import Foundation

struct QuestionRang {
    let index: Int
    let type: QuestionType
    let sum: Int
    
    var imageName: String {
        switch self.type {
        case .usual: "regular"
        case .nonCombustible: "challenge"
        case .victorious: "top"
        }
    }
}

enum QuestionType {
    case usual
    case nonCombustible
    case victorious
}

extension QuestionRang {
    static func getQuestions()  -> [QuestionRang] {
        [
            QuestionRang(
                index: 1,
                type: .usual,
                sum: 100
            ),
            QuestionRang(
                index: 2,
                type: .usual,
                sum: 200
            ),
            QuestionRang(
                index: 3,
                type: .usual,
                sum: 300
            ),
            QuestionRang(
                index: 4,
                type: .usual,
                sum: 500
            ),
            QuestionRang(
                index: 5,
                type: .nonCombustible,
                sum: 1_000
            ),
            QuestionRang(
                index: 6,
                type: .usual,
                sum: 2_000
            ),
            QuestionRang(
                index: 7,
                type: .usual,
                sum: 4_000
            ),
            QuestionRang(
                index: 8,
                type: .usual,
                sum: 8_000
            ),
            QuestionRang(
                index: 9,
                type: .usual,
                sum: 16_000
            ),
            QuestionRang(
                index: 10,
                type: .nonCombustible,
                sum: 32_000
            ),
            QuestionRang(
                index: 11,
                type: .usual,
                sum: 64_000
            ),
            QuestionRang(
                index: 12,
                type: .usual,
                sum: 125_000
            ),
            QuestionRang(
                index: 13,
                type: .usual,
                sum: 250_000
            ),
            QuestionRang(
                index: 14,
                type: .usual,
                sum: 500_000
            ),
            QuestionRang(
                index: 15,
                type: .victorious,
                sum: 1_000_000
            )
        ].reversed()
    }
}
