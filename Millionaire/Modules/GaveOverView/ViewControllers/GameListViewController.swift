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
    
    // MARK: - UI Elements
    private let backgroundView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bgMain"))
        imageView.contentMode = .scaleToFill
        return imageView
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
        view.addSubview(backgroundView)
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - GameListViewProtocol
extension GameListViewController: GameListViewProtocol {
    
}
