//
//  RulesModel.swift
//  Millionaire
//
//  Created by Варвара Уткина on 24.07.2025.
//

import UIKit

struct RulesModel {
    let title: String
    let rules: NSMutableAttributedString
    let buttonTitle: String
}

extension RulesModel {
    static func getRules() -> RulesModel {
        let fullText = """
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
            """
        let attributedText = NSMutableAttributedString(string: fullText)
        
        let baseAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: FontType.regular.rawValue, size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .regular),
            .foregroundColor: UIColor.white
        ]
        
        let highlightedAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: FontType.bold.rawValue, size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .bold),
            .foregroundColor: UIColor.white
        ]

        attributedText.addAttributes(baseAttributes, range: NSRange(location: 0, length: fullText.count))
        
        let phrasesToHighlight = [
            "Goal:",
            "15 questions correctly",
            "1,000,000 RUB!",
            "Safe Havens:",
            "✔ 1,000 RUB",
            "✔ 32,000 RUB",
            "How to Play:",
            "Lifelines (use ‘em smart!):",
            "50:50",
            "Ask the Audience",
            "Phone a Friend",
            "Pro Tip:",
            "Ready? Strike it rich—or laugh all the way to 1,000 RUB!"
        ]
        
        for phrase in phrasesToHighlight {
            let range = (fullText as NSString).range(of: phrase)
            if range.location != NSNotFound {
                attributedText.addAttributes(highlightedAttributes, range: range)
            }
        }

        return RulesModel(
            title: "Rules",
            rules: attributedText,
            buttonTitle: "Close"
        )
    }
}
