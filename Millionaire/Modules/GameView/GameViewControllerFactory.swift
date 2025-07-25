//
//  GameViewControllerFactory.swift
//  Millionaire
//
//  Created by artyom s on 23.07.2025.
//

import UIKit

protocol GameViewControllerFactoryProtocol {
    func createGameViewController() -> GameViewController
}



final class GameViewControllerFactoryImpl {
    func createGameViewController(question: Int = 0, sum: Int = 999) -> GameViewController {
        let vc = GameViewController()
        
        UINavigationBar.appearance().tintColor = .white
        
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        let questionlbl = UILabel()
        questionlbl.text = "QUESTION #\(question)"
        questionlbl.alpha = 0.5
        questionlbl.font = .init(name: FontType.regular.rawValue, size: 18)
        
        let sumlbl = UILabel()
        sumlbl.textColor = .white
        sumlbl.font = .init(name: FontType.medium.rawValue, size: 16)
        sumlbl.text = "$\(sum)"
        sv.addArrangedSubview(questionlbl)
        sv.addArrangedSubview(sumlbl)
        
        
        vc.navigationItem.titleView = sv
        vc.navigationItem.leftBarButtonItem = .init(image: .arrowBack)
        
        vc.navigationItem.rightBarButtonItem = .init(image: .prizeLadder)
        vc.currentlevel = question
        
        return vc
    }
}


