//
//  QuestionTableViewCell.swift
//  Millionaire
//
//  Created by Варвара Уткина on 22.07.2025.
//

import UIKit
import SnapKit

final class QuestionTableViewCell: UITableViewCell {
    
    static let identifier = "QuestionTableViewCell"
    
    private enum Drawing {
        static var horizontalInset: CGFloat { 32 }
        static var stackHorizontalInset: CGFloat { 24 }
    }
    
    // MARK: - UI Elements
    private let currentCellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "current")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        return imageView
    }()
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        return imageView
    }()
    private let questionStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    private let questionNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: FontType.bold.rawValue, size: 18)
        return label
    }()
    private let moneyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: FontType.bold.rawValue, size: 18)
        return label
    }()
    
    // MARK: - Private Properties
    private var type: QuestionType?
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(with question: QuestionRang, isCurrent: Bool) {
        questionNumberLabel.text = question.index.description
        moneyLabel.text = formattedMoneyString(question.sum)
        type = question.type
        cellImageView.image = UIImage(named: question.imageName)
        
        if isCurrent {
            startAnimation()
        }
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(currentCellImageView)
        contentView.addSubview(cellImageView)
        contentView.addSubview(questionStack)
        questionStack.addArrangedSubview(questionNumberLabel)
        questionStack.addArrangedSubview(moneyLabel)
        
        cellImageView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView)
            make.horizontalEdges.equalTo(contentView).inset(Drawing.horizontalInset)
        }
        currentCellImageView.snp.makeConstraints { make in
            make.edges.equalTo(cellImageView)
        }
        questionNumberLabel.snp.makeConstraints { make in
            make.width.equalTo(50)
        }
        questionStack.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(
                Drawing.horizontalInset + Drawing.stackHorizontalInset
            )
            make.centerY.equalTo(contentView)
        }
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
    
    private func startAnimation() {
        UIView.animate(
            withDuration: 0.3,
            delay: 0.1,
            options: .curveEaseInOut) {
                self.cellImageView.alpha = 0
            } completion: { _ in
                UIView.animate(
                    withDuration: 0.3,
                    delay: 0,
                    options: .curveEaseInOut) {
                        self.cellImageView.alpha = 1
                    } completion: { _ in
                        UIView.animate(
                            withDuration: 0.3,
                            delay: 0,
                            options: .curveEaseInOut) {
                                self.cellImageView.alpha = 0
                            } completion: { _ in
                                UIView.animate(
                                    withDuration: 0.3,
                                    delay: 0,
                                    options: .curveEaseInOut) {
                                        self.cellImageView.alpha = 1
                                    } completion: { _ in
                                        UIView.animate(
                                            withDuration: 0.3,
                                            animations: {
                                                self.cellImageView.alpha = 0
                                            }
                                        )
                                    }
                            }
                    }
            }
        
    }
}
