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
        static var logoSize: CGSize { CGSize(width: 85, height: 85) }
        
        static var tableYOffset: CGFloat { 15 }
        static var cellWidthToHeightRation: CGFloat { 311 / 36 }
        
        static var alertYOffset: CGFloat { 25 }
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
    private let logoView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowRadius = 20
        imageView.layer.shadowOffset = .zero
        imageView.layer.masksToBounds = false
        return imageView
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
    private let alertView = GameOverAlertView()
    
    // MARK: - Dependencies
    var presenter: GameListPresenterProtocol!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.alertView.startAnimation()
        }
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        setupBarButtonItem()
        
        view.addSubviews(backgroundView, scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(questionsTable, logoView, alertView)
        
        alertView.prepareAnimation()
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
        logoView.snp.makeConstraints { make in
            make.size.equalTo(Drawing.logoSize)
            make.centerX.equalToSuperview()
            make.top.equalTo(contentView)
        }
        questionsTable.snp.makeConstraints { make in
            make.top.equalTo(logoView.snp.bottom).inset(Drawing.tableYOffset)
            make.bottom.horizontalEdges.equalToSuperview()
            make.height.equalTo(questionsTable.rowHeight * CGFloat(presenter.questions.count))
        }
        alertView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-Drawing.alertYOffset)
            make.horizontalEdges.equalToSuperview().inset(Drawing.horizontalInset)
            make.height.equalTo(150)
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
