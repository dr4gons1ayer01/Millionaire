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
    let summ: Int
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
                summ: 100
            ),
            QuestionRang(
                index: 2,
                type: .usual,
                summ: 200
            ),
            QuestionRang(
                index: 3,
                type: .usual,
                summ: 300
            ),
            QuestionRang(
                index: 4,
                type: .usual,
                summ: 500
            ),
            QuestionRang(
                index: 5,
                type: .nonCombustible,
                summ: 1_000
            ),
            QuestionRang(
                index: 6,
                type: .usual,
                summ: 2_000
            ),
            QuestionRang(
                index: 7,
                type: .usual,
                summ: 4_000
            ),
            QuestionRang(
                index: 8,
                type: .usual,
                summ: 8_000
            ),
            QuestionRang(
                index: 9,
                type: .usual,
                summ: 16_000
            ),
            QuestionRang(
                index: 10,
                type: .nonCombustible,
                summ: 32_000
            ),
            QuestionRang(
                index: 11,
                type: .usual,
                summ: 64_000
            ),
            QuestionRang(
                index: 12,
                type: .usual,
                summ: 125_000
            ),
            QuestionRang(
                index: 13,
                type: .usual,
                summ: 250_000
            ),
            QuestionRang(
                index: 14,
                type: .usual,
                summ: 500_000
            ),
            QuestionRang(
                index: 15,
                type: .victorious,
                summ: 1_000_000
            )
        ]
    }
}
