//
//  Question+Mock.swift
//  Millionaire
//
//  Created by Иван Семенов on 21.07.2025.
//

import Foundation

extension Question {
    static func mockQuestions() -> [Question] {
        return [
            Question(
                questionText: "Столица Франции?",
                answers: [
                    Answer(text: "Лондон"),
                    Answer(text: "Париж"),
                    Answer(text: "Берлин"),
                    Answer(text: "Мадрид")
                ],
                correctAnswerIndex: 1
            ),
            Question(
                questionText: "2 + 2?",
                answers: [
                    Answer(text: "3"),
                    Answer(text: "4"),
                    Answer(text: "5"),
                    Answer(text: "22")
                ],
                correctAnswerIndex: 1
            )
        ]
    }
}
