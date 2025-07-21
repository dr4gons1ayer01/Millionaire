//
//  Question.swift
//  Millionaire
//
//  Created by Иван Семенов on 21.07.2025.
//

import Foundation

struct Question {
    let questionText: String
    let answers: [Answer]
    let correctAnswerIndex: Int
}

struct Answer {
    let text: String
}
