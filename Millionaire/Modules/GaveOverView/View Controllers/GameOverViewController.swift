//
//  GameOverViewController.swift
//  Millionaire
//
//  Created by Дарья Балацун on 22.07.25.
//

import UIKit

protocol GameOverViewProtocol: AnyObject {
    func displayGameOver(level: Int, score: Int)
}

final class GameOverViewController: UIViewController, GameOverViewProtocol {
    
    // MARK: - UI Elements
    private let backgroundView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bgMain"))
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let gameOverLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "Game over!"
        lb.font = UIFont(name: FontType.bold.rawValue, size: 28)
        return lb
    }()
    
    private let scoreLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.textAlignment = .left
        lb.font = UIFont(name: FontType.bold.rawValue, size: 22)
        return lb
    }()
    
    private let levelLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .lightGray
        lb.textAlignment = .center
        lb.font = UIFont(name: FontType.regular.rawValue, size: 18)
        return lb
    }()
    
    private let coinIconView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "coinBold"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let newGameButton = UIButton(type: .custom)
    private let mainScreenButton = UIButton(type: .custom)
    
    // MARK: - Initializers
    init(presenter: GameOverPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Dependencies
    private let presenter: GameOverPresenterProtocol
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        setupUI()
        presenter.viewDidLoad()
    }
    
    // MARK: - GameOverViewProtocol
    func displayGameOver(level: Int, score: Int) {
        levelLabel.text = "Level \(level)"
        scoreLabel.text = formattedMoneyString(score)
    }
}

// MARK: - SetUp UI
extension GameOverViewController {
    func setupUI() {
        setupBackgroundView()
        setupMainStackView()
        setupButtons()
    }
    
    func setupBackgroundView() {
        view.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupMainStackView() {
        let scoreStack = UIStackView(arrangedSubviews: [coinIconView, scoreLabel])
        view.addSubview(scoreStack)
        scoreStack.translatesAutoresizingMaskIntoConstraints = false
        scoreStack.spacing = 0
        scoreStack.axis = .horizontal
        
        let mainStackView = UIStackView(arrangedSubviews: [logoImageView, gameOverLabel, levelLabel, scoreStack])
        view.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.spacing = 10
        mainStackView.distribution = .equalCentering
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.heightAnchor.constraint(equalToConstant: 324),
            logoImageView.heightAnchor.constraint(equalToConstant: 195),
            logoImageView.widthAnchor.constraint(equalToConstant: 195),
            coinIconView.heightAnchor.constraint(equalToConstant: 44),
            coinIconView.widthAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func setupButtons() {
        view.addSubview(newGameButton)
        newGameButton.setBackgroundImage(UIImage(named: "yellowAnswer"), for: .normal)
        newGameButton.addTarget(self, action: #selector(newGameTapped), for: .touchUpInside)
        newGameButton.setTitle("New Game", for: .normal)
        newGameButton.setTitleColor(.white, for: .normal)
        newGameButton.titleLabel?.font = UIFont(name: FontType.bold.rawValue, size: 24)
        newGameButton.titleLabel?.textAlignment = .center
        newGameButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainScreenButton)
        mainScreenButton.setBackgroundImage(UIImage(named: "blueAnswer"), for: .normal)
        mainScreenButton.addTarget(self, action: #selector(mainScreenTapped), for: .touchUpInside)
        mainScreenButton.setTitle("Main Screen", for: .normal)
        mainScreenButton.setTitleColor(.white, for: .normal)
        mainScreenButton.titleLabel?.font = UIFont(name: FontType.bold.rawValue, size: 24)
        mainScreenButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainScreenButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            mainScreenButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainScreenButton.heightAnchor.constraint(equalToConstant: 62),
            newGameButton.bottomAnchor.constraint(equalTo: mainScreenButton.topAnchor, constant: -10),
            newGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newGameButton.heightAnchor.constraint(equalTo: mainScreenButton.heightAnchor)
        ])
    }
    
    // MARK: - Private Methods
    private func formattedMoneyString(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.usesGroupingSeparator = true
        
        guard let formattedNumber = formatter.string(from: NSNumber(value: number)) else {
            return number.description
        }
        return "\(formattedNumber) руб."
    }
    
    // MARK: - Actions
    @objc private func newGameTapped() {
        presenter.didTapNewGame()
    }
    
    @objc private func mainScreenTapped() {
        presenter.didTapMainScreen()
    }
}
