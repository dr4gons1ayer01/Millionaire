//
//  User.swift
//  Millionaire
//
//  Created by Варвара Уткина on 25.07.2025.
//

import Foundation

struct User {
    var currentLevel: Int = 1
    var gameState: GameState
    
    func getSum() -> Int {
        let gameRangs = QuestionRang.getQuestions()
        guard gameRangs.indices.contains(currentLevel) else { return -1 }
        let rang = gameRangs[gameRangs.count - 1 - currentLevel]
        return rang.sum
    }
}

enum GameState {
    case isOn
    case isOff
}
