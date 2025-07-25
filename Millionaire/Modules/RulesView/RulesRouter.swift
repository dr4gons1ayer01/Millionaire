//
//  RulesRouter.swift
//  Millionaire
//
//  Created by Эйнар on 22.07.2025.
//

import UIKit
import Foundation

protocol RulesRouterProtocol {
    func close()
}

final class RulesRouter: RulesRouterProtocol {
    weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func close() {
        viewController?.dismiss(animated: true)
    }
}
