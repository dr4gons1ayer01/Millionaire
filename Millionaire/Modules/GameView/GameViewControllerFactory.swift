//
//  GameViewControllerFactory.swift
//  Millionaire
//
//  Created by artyom s on 23.07.2025.
//

import UIKit

protocol GameViewControllerFactoryProtocol {
    func createGameViewController(questionNum: Int, sum: Int) -> GameViewController
}


enum Constants {
    enum GameView {
        static let questionFontSize: CGFloat = 18
        static let sumFontSize: CGFloat = 16
        static let questionAlpha: CGFloat = 0.5
        static let tintColor: UIColor = .white
    }
}


final class GameViewControllerFactoryImpl: GameViewControllerFactoryProtocol {
    func createGameViewController(questionNum: Int, sum: Int) -> GameViewController {
        let vc = GameViewController()
        
        UINavigationBar.appearance().tintColor = .white
        
       
        let sv = createTitleStackView(questionNum: questionNum, sum: sum)
        
        vc.navigationItem.titleView = sv
        vc.navigationItem.leftBarButtonItem = .init(image: .arrowBack)
        
        vc.navigationItem.rightBarButtonItem = .init(image: .prizeLadder)
        
        return vc
    }
    
    private func createTitleStackView(questionNum: Int, sum: Int) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        
        let questionLabel = UILabel()
        questionLabel.text = "QUESTION #\(questionNum)"
        questionLabel.alpha = Constants.GameView.questionAlpha
        questionLabel.font = UIFont(name: FontType.regular.rawValue, size: Constants.GameView.questionFontSize) ?? .systemFont(ofSize: Constants.GameView.questionFontSize)
        
        let sumLabel = UILabel()
        sumLabel.textColor = Constants.GameView.tintColor
        sumLabel.font = UIFont(name: FontType.medium.rawValue, size: Constants.GameView.sumFontSize) ?? .systemFont(ofSize: Constants.GameView.sumFontSize)
        sumLabel.text = "$\(sum)"
        
        stackView.addArrangedSubview(questionLabel)
        stackView.addArrangedSubview(sumLabel)
        
        return stackView
    }
}


