//
//  GameViewController.swift
//  Millionaire
//
//  Created by artyom s on 22.07.2025.
//

import UIKit



enum AssistActionType {
    case call, fif2fif, audience
}



// navigation actions: modals, push, tabbar, fullscreen...
protocol GameViewNavigationDelegate {
    func didPressBackBarItem()
    func didPressRightBarItem()
}


final class GameViewController: UIViewController, GameViewProtocol {
    var questions: [Question] = Question.mockQuestions()
    
    var timerService: TimerService!
    var assistService: AssistActionServiceDelegate!
    var navigator: GameViewNavigationDelegate?
    
    var currentQuestion: Question { questions[currentlevel] }
    var currentlevel = 0
    var timerValue = 30
    
    private func setupNavbarActions() {
        navigationItem.leftBarButtonItem?.target = self
        navigationItem.rightBarButtonItem?.target = self
        navigationItem.leftBarButtonItem?.action = #selector(didPressBackBarItem)
        navigationItem.rightBarButtonItem?.action = #selector(didPressRightBarItem)
    }
    
    @objc func didPressBackBarItem() {
        // needs navigation
        print("hello")
        navigator?.didPressBackBarItem()
    }
    
    @objc func didPressRightBarItem() {
        
        // needs navigation
        print("hello right")
        navigator?.didPressRightBarItem()
    }
    
    // presenter candidate
    func didSelectAnswer(index: Int, answerRows: [AnswerRow]) {
        
        
        let isCorrect = currentQuestion.correctAnswerIndex == index
        
        gameView.disableHelpers()
        let row = answerRows[index]
        if row.isDisabled {return}
        
        row.configure(for: .highlighted)
        
        row.superview!.gestureRecognizers?.forEach({$0.isEnabled = false})
        
        //play intriguiing
        SoundManager.shared.playSound(.accepted)
        timerService.stop()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self ] in
            guard let self = self else {fatalError("missing self")}
            
            // start music
            if isCorrect {
                row.configure(for: .rightGreen)
                self.timerService.stop()
                SoundManager.shared.stopSound()
                SoundManager.shared.playSound(.correct)
                // make asnwerRowGreen
            } else {
                row.configure(for: .wrong)
                let correctRow = answerRows[self.currentQuestion.correctAnswerIndex]
                correctRow.configure(for: .correctAnswer)
                
                answerRows.forEach({$0.isUserInteractionEnabled = false})
                
                self.timerService.stop()
                SoundManager.shared.stopSound()
                SoundManager.shared.playSound(.wrong)
            }
        }
        
    }
    
    // presenter candidate
    func didSelectAssist(assistType: AssistActionType, button: UIButton, answerRows: [AnswerRow]) {
        button.isEnabled = false
        button.alpha = 0.5
        gameView.disableHelpers() // TODO: need to remove?
        
        switch assistType {
        case .call:
            let answerIndex = assistService.call(rightIndex: currentQuestion.correctAnswerIndex)
            answerRows[answerIndex].blink()
        case .fif2fif:
            let (first, second) = assistService.fif2fif(rightIndex: currentQuestion.correctAnswerIndex)
            
            for (index, row) in answerRows.enumerated() {
                if index != first && index != second {
                    row.isDisabled = true
                }
            }
            
        case .audience:
            let answerIndex = assistService.audience(rightIndex: currentQuestion.correctAnswerIndex)
            answerRows[answerIndex].blink()
            
        }
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
        
        setupNavbarActions()
        
        SoundManager.shared.playSound(.clock)
        
        // injection candidate
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
        
        // injection candidate
        assistService = AssistActionService()
        
    }
    
}




//@available(iOS 17, *)
//#Preview {
//    
//    UINavigationController(rootViewController: GameViewControllerFactoryImpl().createGameViewController())
//}
//
