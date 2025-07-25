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
    
    private let userDefaultsManager = UserDefaultsManager.shared
    
    func didSelectAnswer(index: Int, row: AnswerRow) {
        guard var user = userDefaultsManager.getUser() else { return }
        let gameList: GameListViewController
        let isCorrect = currentQuestion.correctAnswerIndex == index
        
        // start music
        if isCorrect {
            row.configure(for: .rightGreen)
            timerService.stop()
            // start victorius music
            SoundManager.shared.stopSound()
            SoundManager.shared.playSound(.correct)
            // make asnwerRowGreen
            gameList = GameListViewController(gameType: .win(index: user.currentLevel))
            user.updateLevel()
        } else {
            row.configure(for: .wrong)
            
            timerService.stop()
            SoundManager.shared.stopSound()
            SoundManager.shared.playSound(.wrong)
            gameList = GameListViewController(gameType: .loose(index: user.currentLevel))
            user.gameOver()
        }
        userDefaultsManager.saveUser(user)
        
        let presenter = GameListPresenter(view: gameList)
        gameList.presenter = presenter
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.navigationController?.pushViewController(gameList, animated: true)
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
        
        gameView.setupQuestion(by: currentlevel)
        
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
