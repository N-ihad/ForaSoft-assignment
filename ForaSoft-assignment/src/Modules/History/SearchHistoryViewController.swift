//
//  SearchHistoryViewController.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 1/13/21.
//

import UIKit

protocol SearchHistoryViewControllerDelegate: AnyObject {
    func searchHistoryViewControllerDidSelectSearchedAlbum(withTitle title: String)
}

final class SearchHistoryViewController: UIViewController {

    weak var delegate: SearchHistoryViewControllerDelegate?

    private let identifier = "cell"
    private let tableView = UITableView()

    private var searchedAlbums = PersistenceManager.shared.searchedAlbums {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        layout()
        style()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchedAlbums = PersistenceManager.shared.searchedAlbums
    }

    private func setup() {
        navigationItem.title = "Search History"

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 44
        tableView.register(SearchHistoryTableViewCell.self, forCellReuseIdentifier: identifier)
    }

    private func layout() {
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewSafeArea()
    }

    private func style() {
        view.backgroundColor = .white
    }
}

// MARK: - UITableViewDelegate / UITableViewDataSource
extension SearchHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedAlbums.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! SearchHistoryTableViewCell
        cell.set(withTitle: searchedAlbums[indexPath.row])
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.searchHistoryViewControllerDidSelectSearchedAlbum(withTitle: searchedAlbums[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        tabBarController?.selectedIndex = 0
    }
}

// MARK: - SearchHistoryTableViewCellDelegate
extension SearchHistoryViewController: SearchHistoryTableViewCellDelegate {
    func searchHistoryTableViewCellDidReceiveDeleteTap(_ cell: SearchHistoryTableViewCell, title: String) {
        PersistenceManager.shared.deleteSearchedAlbum(title)
        searchedAlbums = PersistenceManager.shared.searchedAlbums
    }
}
