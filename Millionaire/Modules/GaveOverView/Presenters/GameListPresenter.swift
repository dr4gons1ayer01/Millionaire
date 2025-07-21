//
//  GameListPresenter.swift
//  Millionaire
//
//  Created by Варвара Уткина on 21.07.2025.
//

import Foundation

protocol GameListPresenterProtocol {
    
}

final class GameListPresenter: GameListPresenterProtocol {
    
    // MARK: - Dependencies
    weak var view: GameListViewProtocol?
    
    // MARK: - Initializers
    init(view: GameListViewProtocol) {
        self.view = view
    }
}
