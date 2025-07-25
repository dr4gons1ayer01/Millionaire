//
//  GameView.swift
//  Millionaire
//
//  Created by artyom s on 23.07.2025.
//

import UIKit

// what view sends
protocol GameViewProtocol: AnyObject {
    func didSelectAnswer(index: Int, row: AnswerRow)
    func didSelectAssist(index: Int)
}

// navbar stub
protocol GameViewNavBarDelegate {
    func didPressBackBarItem()
    func didPressRightBarItem()
}

final class GameView: UIView {
    
    var delegate: GameViewProtocol?

    
    // MARK: Views
    let timerView: TimerView = {
        let v = TimerView(timerInitialValue: 30)
        
        return v
    }()
    
    private let questionText: UITextView = {
        let v = UITextView()
        v.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, "
        v.isSelectable = false
        v.showsHorizontalScrollIndicator = false
        v.showsVerticalScrollIndicator = false
        v.backgroundColor = .clear
        v.font = .init(name: FontType.medium.rawValue, size: 24)
        v.textColor = .white
        v.textAlignment = .center
        
        
        return v
    }()
    
    private lazy var quesitonColumns: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.distribution = .fillEqually
        v.spacing = 16
//        v.addArrangedSubview(AnswerRow(index: "A:", text: "question 1"))
//        v.addArrangedSubview(AnswerRow(index: "B:", text: "question 2"))
//        v.addArrangedSubview(AnswerRow(index: "C:", text: "question 3"))
//        v.addArrangedSubview(AnswerRow(index: "D:", text: "question 4"))
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didChooseAnswer))
        v.addGestureRecognizer(tap)
        return v
    }()
    
    private lazy var helpersStack: UIStackView = {
        let v = UIStackView()
        
        let fif2fif = UIButton(type: .system)
        let audience = UIButton(type: .system)
        let call = UIButton(type: .system)
        
        audience.setImage(.audience, for: .normal)
        fif2fif.setImage(._5050, for: .normal)
        call.setImage(.call, for: .normal)
        
        v.distribution = .fillProportionally
        v.spacing = 24
        v.addArrangedSubview(fif2fif)
        v.addArrangedSubview(audience)
        v.addArrangedSubview(call)
        
        audience.addTarget(self, action: #selector(didChooseAssist), for: .touchUpInside)
        fif2fif.addTarget(self, action: #selector(didChooseAssist), for: .touchUpInside)
        call.addTarget(self, action: #selector(didChooseAssist), for: .touchUpInside)
        
        return v
    }()
    
    convenience init(delegate: GameViewProtocol) {
        self.init(frame: .zero)
        self.delegate = delegate
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBg()
        makeLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func setupQuestion(by currentLevel: Int) {
        let questions = Question.mockQuestions()
        guard questions.indices.contains(currentLevel) else { return }
        let model = questions[currentLevel]
        questionText.text = model.questionText
        
        zip(model.answers, ["A:","B:","C:","D:"]).forEach { (answer, letter) in
            quesitonColumns.addArrangedSubview(AnswerRow(index: letter, text: answer.text))
        }
    }
    
    // MARK: - Private Methods
    private func makeLayout() {
        [timerView, questionText, quesitonColumns, helpersStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        
        NSLayoutConstraint.activate([
            timerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            timerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            
            questionText.topAnchor.constraint(equalToSystemSpacingBelow: timerView.bottomAnchor, multiplier: 3),
            questionText.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 3),
            trailingAnchor.constraint(equalToSystemSpacingAfter: questionText.trailingAnchor, multiplier: 3),
            questionText.heightAnchor.constraint(equalToConstant: 147),
            
            quesitonColumns.topAnchor.constraint(equalToSystemSpacingBelow: questionText.bottomAnchor, multiplier: 8),
            
            quesitonColumns.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 3),
            trailingAnchor.constraint(equalToSystemSpacingAfter: quesitonColumns.trailingAnchor, multiplier: 3),
            
            helpersStack.topAnchor.constraint(equalToSystemSpacingBelow: quesitonColumns.bottomAnchor, multiplier: 3),
            helpersStack.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 3),
            trailingAnchor.constraint(equalToSystemSpacingAfter: helpersStack.trailingAnchor, multiplier: 3),
            bottomAnchor.constraint(equalToSystemSpacingBelow: helpersStack.bottomAnchor, multiplier: 3)
            
            
        ])
    }
    
    private func setupBg() {
        let v = UIImageView(image: .mainBgAlt)
        addSubview(v)
        v.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            v.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: v.trailingAnchor),
            v.topAnchor.constraint(equalTo: topAnchor),
            bottomAnchor.constraint(equalTo: v.bottomAnchor),
            
        ])
    }
    
    // MARK: Handlers
    @objc private func didChooseAnswer(sender: UITapGestureRecognizer) {
        let sv = sender.view as! UIStackView
        let touchLoc = sender.location(in: sv)
        let index = sv.arrangedSubviews.firstIndex(where: {
            $0.frame.contains(touchLoc)
        })
        
        let view = sv.arrangedSubviews[index!] as! AnswerRow
        
        delegate?.didSelectAnswer(index: index!, row: view)
    }
    
    @objc private func didChooseAssist(sender: UIButton) {
        guard let img = sender.currentImage else {return}
        switch img {
        case UIImage._5050:
            delegate?.didSelectAssist(index: 0)
        case UIImage.audience:
            delegate?.didSelectAssist(index: 1)
        case UIImage.call:
            delegate?.didSelectAssist(index: 2)
        default:
            fatalError("image does not exist")
        }

        
        
    }
}

