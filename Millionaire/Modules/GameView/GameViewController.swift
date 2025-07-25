//
//  GameViewController.swift
//  Millionaire
//
//  Created by artyom s on 22.07.2025.
//

import UIKit




final class GameViewController: UIViewController, GameViewProtocol {
    var questions: [Question] = Question.mockQuestions()
    
    var timerService: TimerService!
    
    var currentQuestion: Question {
        questions[currentlevel]
    }
    var currentlevel = 0
    var timerValue = 30
    
    func didSelectAnswer(index: Int, row: AnswerRow) {
        let isCorrect = currentQuestion.correctAnswerIndex == index
        // start music
        if isCorrect {
            row.configure(for: .rightGreen)
            timerService.stop()
            // start victorius music
            SoundManager.shared.stopSound()
            SoundManager.shared.playSound(.correct)
            // make asnwerRowGreen
        } else {
            row.configure(for: .wrong)
            
            timerService.stop()
            SoundManager.shared.stopSound()
            SoundManager.shared.playSound(.wrong)
        }
    }
    
    func didSelectAssist(index: Int) {
        
    }
    
    private(set) var gameView: GameView! {
        didSet {
            gameView.delegate = self
        }
    }
    
    override func loadView() {
        self.gameView = GameView()
        view = self.gameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SoundManager.shared.playSound(.clock)
        timerService = TimerService { [weak self] tick in
            
            guard let self = self else {
                fatalError("missing self for logic")
            }
            
            if timerValue > 0 { timerValue -= 1 }
            if timerValue < 15 {gameView.timerView.configure(for: .warn)}
            if timerValue < 5 {gameView.timerView.configure(for: .extraWarn)}
            gameView.timerView.updateTime(val: timerValue)
        }
        timerService.start()
        
    }
    
}




//@available(iOS 17, *)
//#Preview {
//    
//    UINavigationController(rootViewController: GameViewControllerFactoryImpl().createGameViewController())
//}
//
