//
//  RulesModel.swift
//  Millionaire
//
//  Created by Варвара Уткина on 24.07.2025.
//

import UIKit

struct RulesModel {
    let title: String
    let rules: String
    let buttonTitle: String
}

extension RulesModel {
    static func getRules() -> RulesModel {
        RulesModel(
            title: "Rules",
            rules: """
            🚀 Goal: Answer 15 questions correctly to win 1,000,000 RUB! But be careful—one wrong answer, and the game’s over!
            
            💰 Safe Havens:
            ✔ 1,000 RUB (after Q5) – Keep it no matter what!
            ✔ 32,000 RUB (after Q10) – Breathe easy, it’s yours!
            
            ❓ How to Play:
            
            Questions get tougher as you climb!
            
            4 answers, only 1 is correct.
            
            No going back—choose wisely!
            
            🛠 Lifelines (use ‘em smart!):
            1️⃣ 50:50 – Two wrong answers vanish! Poof! ✨
            2️⃣ Ask the Audience – The crowd helps (70% chance they’re right!). 📢
            3️⃣ Phone a Friend – Your genius buddy’s got an 80% success rate! 📞
            
            💡 Pro Tip: Use lifelines on tricky questions—don’t gamble your way to the top!
            
            🎉 Ready? Strike it rich—or laugh all the way to 1,000 RUB! 😉
            """,
            buttonTitle: "Close"
        )
    }
}
