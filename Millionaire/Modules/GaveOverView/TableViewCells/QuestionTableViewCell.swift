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
    
    // MARK: - UI Elements
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
    func configure(with question: QuestionRang) {
        questionNumberLabel.text = question.index.description
        moneyLabel.text = question.summ.description
        type = question.type
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(questionStack)
        questionStack.addArrangedSubview(questionNumberLabel)
        questionStack.addArrangedSubview(moneyLabel)
        
        questionStack.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView)
            make.centerY.equalTo(contentView)
        }
    }
}
