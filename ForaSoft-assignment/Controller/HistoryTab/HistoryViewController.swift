//
//  HistoryViewController.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 1/13/21.
//

import UIKit

private let reuseIdentifier = "cell"

protocol HistoryViewControllerDelegate: class {
    func didSelectRow(with title: String)
}

class HistoryViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: HistoryViewControllerDelegate?
    private var tableView = UITableView()
    
    private var searchedQueries = BackendManager.shared.getRecentSearchedQueries() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchedQueries = BackendManager.shared.getRecentSearchedQueries()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        configureNavBar()
        configureSubviews()
    }
    
    func configureNavBar() {
        navigationItem.title = "History"
    }
    
    func configureSubviews() {
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewSafeArea()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 44
        tableView.register(RecentlySearchedCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
}


// MARK: - UITableViewDelegate / UITableViewDataSource

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedQueries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! RecentlySearchedCell
        cell.set(with: searchedQueries[indexPath.row])
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectRow(with: searchedQueries[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        tabBarController?.selectedIndex = 0
    }
}

// MARK: - RecentlySearchedCellDelegate

extension HistoryViewController: RecentlySearchedCellDelegate {
    func didTapDeleteButton(_ cell: RecentlySearchedCell) {
        BackendManager.shared.deleteRecentSearchedQuery(with: cell.titleLabel.text!)
        searchedQueries = BackendManager.shared.getRecentSearchedQueries()
    }
}
