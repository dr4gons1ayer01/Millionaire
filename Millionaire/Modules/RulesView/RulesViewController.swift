//
//  RulesViewController.swift
//  Millionaire
//
//  Created by Эйнар on 22.07.2025.
//

import UIKit
import Foundation

protocol RulesViewProtocol: AnyObject {
    func updateUI(withTitle title: String, rules: String, buttonTitle: String)
}

final class RulesViewController: UIViewController {
    
    private enum Drawing {
        static var closeTopInset: CGFloat { 17 }
        static var titleInset: CGFloat { 16 }
        static var scrollInset: CGFloat { 32 }
    }
    
    // MARK: - UI Elements
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.alwaysBounceVertical = true
        scroll.alwaysBounceHorizontal = false
        scroll.isDirectionalLockEnabled = true
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontType.bold.rawValue, size: 18)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let rulesTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: FontType.regular.rawValue, size: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont(name: FontType.bold.rawValue, size: 16)
        button.tintColor = .closeBtn
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Dependencies
    var presenter: RulesPresenterProtocol!

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        isModalInPresentation = true
        setupUI()
        setupConstraints()
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .rulesBckgnd

        view.addSubviews(closeButton, titleLabel, scrollView)
        scrollView.addSubview(rulesTextLabel)
        
        presenter.setText()
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                closeButton.topAnchor.constraint(
                    equalTo: view.topAnchor,
                    constant: Drawing.closeTopInset
                ),
                closeButton.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor,
                    constant: Drawing.titleInset
                ),
                
                titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                titleLabel.topAnchor.constraint(
                    equalTo: view.topAnchor,
                    constant: Drawing.titleInset
                ),
                
                scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
                
                rulesTextLabel.topAnchor.constraint(
                    equalTo: scrollView.topAnchor,
                    constant: Drawing.scrollInset
                ),
                rulesTextLabel.leadingAnchor.constraint(
                    equalTo: scrollView.leadingAnchor,
                    constant: Drawing.scrollInset
                ),
                rulesTextLabel.trailingAnchor.constraint(
                    equalTo: scrollView.trailingAnchor,
                    constant: -Drawing.scrollInset
                ),
                rulesTextLabel.widthAnchor.constraint(
                    equalTo: view.widthAnchor,
                    constant: -2 * Drawing.scrollInset
                ),
                rulesTextLabel.bottomAnchor.constraint(
                    equalTo: scrollView.bottomAnchor,
                    constant: -Drawing.scrollInset
                )
            ]
        )
    }

    // MARK: - Actions
    @objc private func closeTapped() {
        presenter.close()
    }
}

// MARK: - RulesViewProtocol
extension RulesViewController: RulesViewProtocol {
    func updateUI(withTitle title: String, rules: String, buttonTitle: String) {
        titleLabel.text = title
        rulesTextLabel.text = rules
        closeButton.setTitle(buttonTitle, for: .normal)
    }
}
