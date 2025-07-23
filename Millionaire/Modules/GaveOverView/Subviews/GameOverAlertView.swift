//
//  GameOverAlertView.swift
//  Millionaire
//
//  Created by Варвара Уткина on 23.07.2025.
//

import UIKit
import SnapKit

final class GameOverAlertView: UIView {
    
    private enum Drawing {
        static var cornerRadius: CGFloat { 20 }
    }
    
    // MARK: - UI Elements
    private var gradientLayer: CAGradientLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = bounds
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = Drawing.cornerRadius
        clipsToBounds = true
        setupGradient()
    }
    
    private func setupGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [
            UIColor.darkBlueBtn.cgColor,
            UIColor.blueBtn.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.5, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        gradient.cornerRadius = layer.cornerRadius
        
        layer.insertSublayer(gradient, at: 0)
        gradientLayer = gradient
    }
    
    // MARK: - Animation
    func prepareAnimation() {
        alpha = 0
        transform = CGAffineTransform(translationX: 0, y: 100)
    }
    
    func startAnimation() {
        UIView.animate(
            withDuration: 1,
            delay: 0.3,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.5,
            options: [.curveEaseOut, .allowUserInteraction],
            animations: { [weak self] in
                self?.alpha = 1
                self?.transform = .identity
            }
        )
    }
}
