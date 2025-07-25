//
//  User.swift
//  Millionaire
//
//  Created by Варвара Уткина on 25.07.2025.
//

import Foundation

struct User: Codable {
    var currentLevel: Int
    var gameStatus: GameStatus
    var score: Int
    
    init() {
        currentLevel = 0
        gameStatus = .isPlaying
        score = 0
    }
    
    func getSum() -> Int {
        let gameRangs = QuestionRang.getQuestions()
        guard gameRangs.indices.contains(currentLevel) else { return -1 }
        let rang = gameRangs[gameRangs.count - 1 - currentLevel]
        return rang.sum
    }
    
    mutating func updateLevel() {
        let rangs = QuestionRang.getQuestions()
        let rang = rangs[rangs.count - 1 - currentLevel]
        score = rang.sum
        
        guard rangs.indices.contains(currentLevel + 1) else { return }
        currentLevel += 1
    }
    
    mutating func gameOver() {
        gameStatus = .isFinished
    }
}

enum GameStatus: Codable {
    case isPlaying
    case isFinished
}
