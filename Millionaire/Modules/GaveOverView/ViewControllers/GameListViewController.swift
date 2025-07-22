//
//  GameListViewController.swift
//  Millionaire
//
//  Created by Варвара Уткина on 21.07.2025.
//

import UIKit
import SnapKit

protocol GameListViewProtocol: AnyObject {
    
}

final class GameListViewController: UIViewController {
    
    private enum Drawing {
        static var horizontalInset: CGFloat { 32 }
        static var cellWidthToHeightRation: CGFloat { 311 / 36 }
    }
    
    // MARK: - UI Elements
    private let backgroundView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bgMain"))
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.isDirectionalLockEnabled = true
        return scrollView
    }()
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .clear
        return contentView
    }()
    private let questionsTable: UITableView = {
        let table = UITableView()
        table.register(
            QuestionTableViewCell.self,
            forCellReuseIdentifier: QuestionTableViewCell.identifier
        )
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.isScrollEnabled = false
        table.alwaysBounceVertical = false
        table.clipsToBounds = false
        return table
    }()
    
    // MARK: - Dependencies
    var presenter: GameListPresenterProtocol!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        setupBarButtonItem()
        
        view.addSubviews(backgroundView, scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(questionsTable)
        
        questionsTable.rowHeight = calculateCellHeight()
        questionsTable.dataSource = self
        questionsTable.delegate = self
        
        backgroundView.snp.makeConstraints { $0.edges.equalToSuperview() }
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
        }
        questionsTable.snp.makeConstraints {
            $0.top.bottom.horizontalEdges.equalToSuperview()
            $0.height.equalTo(questionsTable.rowHeight * CGFloat(presenter.questions.count))
        }
    }
    
    private func setupBarButtonItem() {
        if navigationController != nil {
            let takeMoneyButton = UIBarButtonItem(
                image: UIImage(named: "takeMoney"),
                style: .plain,
                target: self,
                action: #selector(takeMoneyButtonTapped)
            )
            takeMoneyButton.tintColor = .white
            navigationItem.leftBarButtonItem = takeMoneyButton
        }
    }
    
    // MARK: - Actions
    @objc private func takeMoneyButtonTapped() {
        print("takeMoneyButtonTapped")
    }
    
    // MARK: - Private Methods
    private func calculateCellHeight() -> CGFloat {
        let width = UIScreen.main.bounds.width - Drawing.horizontalInset * 2
        let height = ceil(width / Drawing.cellWidthToHeightRation)
        return height
    }
}

// MARK: - UITableViewDataSource
extension GameListViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        presenter.questions.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: QuestionTableViewCell.identifier,
            for: indexPath
        ) as? QuestionTableViewCell else { return UITableViewCell() }
        
        let question = presenter.questions[indexPath.row]
        cell.configure(with: question)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension GameListViewController: UITableViewDelegate {
    
}

// MARK: - GameListViewProtocol
extension GameListViewController: GameListViewProtocol {
    
}
