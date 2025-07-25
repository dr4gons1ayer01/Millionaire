//
//  AnswerRow.swift
//  Millionaire
//
//  Created by artyom s on 23.07.2025.
//

import UIKit

final class AnswerRow: UIImageView {
    
    enum AnswerRowType {
        case regular, rightGreen, wrong, correctAnswer, highlighted
    }
    
    var isDisabled = false {
        didSet {
            answerLabel.isHidden = true
            answerLabel.isUserInteractionEnabled = false
        }
    }
    
    private lazy var sv: UIStackView = {
        let sv = UIStackView()
        sv.isLayoutMarginsRelativeArrangement = true
        sv.directionalLayoutMargins = .init(top: 0, leading: 24, bottom: 0, trailing: 24)
        return sv
    }()
    
    private let indexLabel: UILabel = {
        let v = UILabel()
        v.textColor = .answerIndexYellow
        v.font = .init(name: FontType.medium.rawValue, size: 18)
        return v
    }()
    
    private let answerLabel: UILabel = {
        let v = UILabel()
        v.textColor = .white
        v.font = .init(name: FontType.medium.rawValue, size: 18)
        return v
    }()
    
    convenience init(index: String, text: String) {
        self.init(frame: .zero)
        indexLabel.text = " \(index)"
        answerLabel.text = " \(text)"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        indexLabel.text = "XX"
        answerLabel.text = "A string is a series of XXXXX"
        setupView()
    }
    
    private func setupView() {
        image = .blueAnswer
        addSubview(sv)
        
        sv.addArrangedSubview(indexLabel)
        sv.addArrangedSubview(answerLabel)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        sv.frame.size = bounds.size
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(for state: AnswerRowType) {
        switch state {
        case .regular:
            image = .blueAnswer
        case .rightGreen:
            image = .greenAnswer
        case .wrong:
            image = .redAnswer
        case .correctAnswer:
            image = .yellowAnswer
        case .highlighted:
            image = .yellowAnswer
        }
    }
}
extension  UIView {
    func blink(duration: TimeInterval = 0.5, repeatCount: Float = 1) {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.autoreverses = true
        animation.repeatCount = repeatCount
        layer.add(animation, forKey: "blink")
    }
}

//@available(iOS 17.0, *)
//#Preview {
//    let btn = UIButton()
//    btn.setImage(.blueAnswer, for: .normal)
//    return btn
//}
//
