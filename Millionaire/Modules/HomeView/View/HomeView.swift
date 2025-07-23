//
//  HomeView.swift
//  Millionaire
//
//  Created by Иван Семенов on 21.07.2025.
//

import UIKit

class HomeView: UIView {
    
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
    
    private let millionareLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "Who Wants to be a Millionare?"
        lb.numberOfLines = 0
        lb.font = UIFont(name: FontType.bold.rawValue, size: 32)
        return lb
    }()
    
    private let newGameButton = UIButton(type: .custom)
    private let helpButton = UIButton(type: .custom)
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeView {
    func setupUI() {
        setupBackgroundView()
        setupHelpButton()
        setupMainStackView()
        setupNewGameButton()
    }
    
    func setupBackgroundView() {
        addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupMainStackView() {
        let mainStackView = UIStackView(arrangedSubviews: [logoImageView, millionareLabel])
        addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.spacing = 10
        mainStackView.distribution = .equalCentering
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 207),
            mainStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainStackView.heightAnchor.constraint(equalToConstant: 324),
            logoImageView.heightAnchor.constraint(equalToConstant: 195),
            logoImageView.widthAnchor.constraint(equalToConstant: 195),
            millionareLabel.widthAnchor.constraint(equalToConstant: 311)
        ])
    }
    
    func setupNewGameButton() {
        addSubview(newGameButton)
        newGameButton.setBackgroundImage(UIImage(named: "yellowAnswer"), for: .normal)
        newGameButton.addTarget(self, action: #selector(newGameTapped), for: .touchUpInside)
        newGameButton.setTitle("New Game", for: .normal)
        newGameButton.setTitleColor(.white, for: .normal)
        newGameButton.titleLabel?.font = UIFont(name: FontType.bold.rawValue, size: 24)
        newGameButton.titleLabel?.textAlignment = .center
        newGameButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newGameButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            newGameButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            newGameButton.heightAnchor.constraint(equalToConstant: 62)
        ])
    }
    
    func setupHelpButton() {
        addSubview(helpButton)
        helpButton.setBackgroundImage(UIImage(named: "help"), for: .normal)
        helpButton.addTarget(self, action: #selector(helpTapped), for: .touchUpInside)
        helpButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            helpButton.topAnchor.constraint(equalTo: topAnchor, constant: 56),
            helpButton.widthAnchor.constraint(equalToConstant: 32),
            helpButton.heightAnchor.constraint(equalToConstant: 32),
            helpButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    // MARK: - Actions
    @objc private func newGameTapped() {
        
    }
    
    @objc private func helpTapped() {
        
    }
}
