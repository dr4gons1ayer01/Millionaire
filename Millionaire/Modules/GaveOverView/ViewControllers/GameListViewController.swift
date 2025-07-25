//
//  GameListViewController.swift
//  Millionaire
//
//  Created by Варвара Уткина on 21.07.2025.
//

import UIKit
import SnapKit

enum GameListType {
    case loose(index: Int)
    case win(index: Int)
    
    var index: Int {
        switch self {
        case .loose(let index): index
        case .win(let index): index
        }
    }
}

protocol GameListViewProtocol: AnyObject {
    func showZeroAlert()
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
    private let darkView: UIView = {
        let dview = UIView()
        dview.backgroundColor = .black.withAlphaComponent(0.5)
        dview.alpha = 0
        return dview
    }()
    
    // MARK: - Dependencies
    var presenter: GameListPresenterProtocol!
    private let userDefaultsManager: UserDefaultsManager
    
    // MARK: - Private Properties
    private let gameType: GameListType
    
    // MARK: - Initializers
    init(gameType: GameListType) {
        self.gameType = gameType
        userDefaultsManager = UserDefaultsManager.shared
        print("init: \(gameType)")
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.changeUI(for: gameType.index)
        if case .win = gameType {
            nextQuestion()
        }
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        setupBarButtonItem()
        
        view.addSubviews(backgroundView, scrollView, darkView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(questionsTable, logoView)
        darkView.addSubview(alertView)
        
        alertView.prepareAnimation()
        questionsTable.rowHeight = calculateCellHeight()
        questionsTable.dataSource = self
        
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
        darkView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        alertView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-Drawing.alertYOffset)
            make.horizontalEdges.equalToSuperview().inset(Drawing.horizontalInset)
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
        let vc = RulesViewController()
        let router = RulesRouter(viewController: vc)
        let presenter = RulesPresenter(view: vc, router: router)
        vc.presenter = presenter
        present(vc, animated: true)
    }
    
    // MARK: - Private Methods
    private func calculateCellHeight() -> CGFloat {
        let width = UIScreen.main.bounds.width - Drawing.horizontalInset * 2
        let height = ceil(width / Drawing.cellWidthToHeightRation)
        return height
    }
    
    private func nextQuestion() {
        guard let user = userDefaultsManager.getUser() else { return }
        print("user: \(user)")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            let factory = GameViewControllerFactoryImpl()
            self?.navigationController?.pushViewController(
                factory.createGameViewController(question: user.currentLevel, sum: user.getSum()),
                animated: false
            )
        }
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
        let animationIndex  = presenter.getAnimationIndex(for: gameType)
        cell.configure(with: question, isCurrent: animationIndex == indexPath.row)
        return cell
    }
}

// MARK: - GameListViewProtocol
extension GameListViewController: GameListViewProtocol {
    func showZeroAlert() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.alertView.startAnimation()
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.darkView.alpha = 1
                self?.navigationItem.leftBarButtonItem?.isEnabled = false
            }
        }
    }
}
