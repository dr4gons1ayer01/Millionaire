//
//  GameListPresenter.swift
//  Millionaire
//
//  Created by Варвара Уткина on 21.07.2025.
//

import Foundation

protocol GameListPresenterProtocol {
    var questions: [QuestionRang] { get }
    
    func changeUI(for index: Int)
    func getAnimationIndex(for gameType: GameListType) -> Int
}

final class GameListPresenter: GameListPresenterProtocol {
    
    // MARK: - Dependencies
    weak var view: GameListViewController?
    
    // MARK: - Public Properties
    var questions: [QuestionRang] = QuestionRang.getQuestions()
    
    // MARK: - Initializers
    init(view: GameListViewController) {
        self.view = view
    }
    
    // MARK: - Public Methods
    func changeUI(for index: Int) {
        if index == -1 {
            view?.showZeroAlert()
        }
    }
    
    func getAnimationIndex(for gameType: GameListType) -> Int {
        switch gameType {
        case .loose(let index): showLooseIndex(for: index)
        case .win(let index): (questions.count - 1) - index
        }
    }
    
    private func showLooseIndex(for currentIndex: Int) -> Int {
        switch currentIndex {
        case 4..<9: return ((questions.count - 1) - 4)
        case 9..<14: return ((questions.count - 1) - 9)
        default:
            view?.showZeroAlert()
            return -100
        }
    }
}
