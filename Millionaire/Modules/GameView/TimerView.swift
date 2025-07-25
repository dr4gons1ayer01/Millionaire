//
//  TimerView.swift
//  Millionaire
//
//  Created by artyom s on 22.07.2025.
//

import UIKit

final class TimerView: UIStackView {
    
    enum TimerViewState {
        case regular, warn, extraWarn
    }
    
    private let icon: UIImageView = {
        let v = UIImageView()
        v.image = .stopwatch
        v.contentMode = .scaleAspectFit
        return v
    }()
    
    private let timeLabel: UILabel = {
        let v = UILabel()
        v.text = "00"
        v.textColor = .white
        v.font = .init(name: FontType.medium.rawValue, size: 24)
        return v
    }()
    
    convenience init(timerInitialValue: Int = 30) {
        self.init(frame: .zero)
        timeLabel.text = "\(30)"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure(for: .regular)
        spacing = 8
        distribution = .fillEqually
        isLayoutMarginsRelativeArrangement = true
        directionalLayoutMargins = .init(top: 10, leading: 16, bottom: 10, trailing: 16)
        addArrangedSubview(icon)
        addArrangedSubview(timeLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func updateTime(val: Int) {
        timeLabel.text = String(format: "%02d", val)
    }
    
    func configure(for state: TimerViewState) {
        switch state {
        case .regular:
            icon.tintColor = .white
            timeLabel.textColor = .white
            backgroundColor = .white.withAlphaComponent(0.25)
        case .warn:
            icon.tintColor = .warnYellow
            timeLabel.textColor = .warnYellow
            backgroundColor = .warnYellow.withAlphaComponent(0.25)
            
        case .extraWarn:
            icon.tintColor = .extraWarnRed
            timeLabel.textColor = .extraWarnRed
            backgroundColor = .extraWarnRed.withAlphaComponent(0.25)
            
        }
    }
}

