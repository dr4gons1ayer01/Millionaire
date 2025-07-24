//
//  GameOverPresenter.swift
//  Millionaire
//
//  Created by Дарья Балацун on 22.07.25.
//

import UIKit

protocol GameOverPresenterProtocol: AnyObject {
    var view: GameOverViewProtocol? { get set }
    func viewDidLoad()
    func didTapNewGame()
    func didTapMainScreen()
}

final class GameOverPresenter: GameOverPresenterProtocol {
    
    weak var view: GameOverViewProtocol?
    private let score: Int
    private let level: Int
    private weak var navigationController: UIViewController?
    
    init(level: Int, score: Int, navigationController: UIViewController?) {
        self.navigationController = navigationController
        self.score = score
        self.level = level
    }
    
    func viewDidLoad() {
        view?.displayGameOver(level: level, score: score)
    }
    
    func didTapNewGame() {
        
    }
    
    func didTapMainScreen() {
        
    }
}
