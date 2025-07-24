//
//  RulesPresenter.swift
//  Millionaire
//
//  Created by Эйнар on 22.07.2025.
//

import UIKit
import Foundation

protocol RulesPresenterProtocol {
    func setText()
    func close()
}

final class RulesPresenter: RulesPresenterProtocol {
    
    // MARK: - Dependencies
    weak var view: RulesViewProtocol?
    var router: RulesRouterProtocol

    // MARK: - Initializers
    init(view: RulesViewProtocol, router: RulesRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    // MARK: - Public Methods
    func setText() {
        let rulesModel = RulesModel.getRules()
        view?.updateUI(
            withTitle: rulesModel.title,
            rules: rulesModel.rules,
            buttonTitle: rulesModel.buttonTitle
        )
    }

    func close() {
        router.close()
    }
}
