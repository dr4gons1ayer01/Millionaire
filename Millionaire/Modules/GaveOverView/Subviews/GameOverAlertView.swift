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
        static var imageWidthToHeightRation: CGFloat { 311 / 36 }
        
        static var horizontalInset: CGFloat { 16 }
        static var superviewHorizontalInset: CGFloat { 32 }
        
        static var stackTopInset: CGFloat { 8 }
    }
    
    // MARK: - UI Elements
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "regular")
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "You won:"
        label.textColor = .white.withAlphaComponent(0.7)
        label.textAlignment = .center
        label.font = UIFont(name: FontType.regular.rawValue, size: 16)
        return label
    }()
    private let questionStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    private let questionNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: FontType.bold.rawValue, size: 18)
        return label
    }()
    private let moneyLabel: UILabel = {
        let label = UILabel()
        label.text = "0 руб."
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: FontType.bold.rawValue, size: 18)
        return label
    }()
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
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 3
        clipsToBounds = true
        setupGradient()
        
        addSubviews(titleLabel, cellImageView)
        cellImageView.addSubview(questionStack)
        questionStack.addArrangedSubview(questionNumberLabel)
        questionStack.addArrangedSubview(moneyLabel)
        
        snp.makeConstraints { make in
            make.height.equalTo(calculateHeight())
        }
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(Drawing.horizontalInset)
        }
        cellImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Drawing.horizontalInset)
            make.height.equalTo(calculateImageHeight())
            make.top.equalTo(titleLabel.snp.bottom).offset(Drawing.stackTopInset)
        }
        questionStack.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(Drawing.horizontalInset)
        }
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
    
    private func calculateImageHeight() -> CGFloat {
        let width = UIScreen.main.bounds.width
        - 2 * Drawing.superviewHorizontalInset
        - 2 * Drawing.horizontalInset
        
        let height = ceil(width / Drawing.imageWidthToHeightRation)
        return height
    }
    
    private func calculateHeight() -> CGFloat {
        let maxWidth = UIScreen.main.bounds.width
        - 2 * Drawing.superviewHorizontalInset
        - 2 * Drawing.horizontalInset
        
        titleLabel.preferredMaxLayoutWidth = maxWidth
        
        let titleLabelHeight = titleLabel.systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize
        ).height
        
        let titleHeight = Drawing.horizontalInset
        + titleLabelHeight
        + Drawing.stackTopInset
        let imageHeight = calculateImageHeight()
        + Drawing.superviewHorizontalInset
        
        return titleHeight + imageHeight
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
