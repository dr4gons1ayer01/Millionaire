//
//  HomeViewController.swift
//  Millionaire
//
//  Created by Иван Семенов on 21.07.2025.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let homeView = HomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        setupUI()
//        showGameOverViewController(level: 8, score: 15000)
    }
    
    func showGameOverViewController(level: Int, score: Int) {
        let presenter = GameOverPresenter(level: level, score: score, navigationController: self.navigationController)
        let gameOverVC = GameOverViewController(presenter: presenter)
        navigationController?.pushViewController(gameOverVC, animated: true)
    }
}

// MARK: - SetUp UI
extension HomeViewController {
    func setupUI() {
        setupHomeViewController()
    }
    
    func setupHomeViewController() {
        view.addSubview(homeView)
        
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: view.topAnchor),
            homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
