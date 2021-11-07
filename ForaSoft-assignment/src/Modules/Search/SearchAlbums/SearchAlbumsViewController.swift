//
//  SearchAlbumsViewController.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 1/13/21.
//

import UIKit
import PureLayout

final class SearchAlbumsViewController: UIViewController {

    private var albums = [Album]() {
        didSet {
            collectionView.reloadData()
            stopLoading()
        }
    }

    private let identifier = "cell"
    private let searchController = UISearchController(searchResultsController: nil)

    private let loadingView: UIView = {
        let loadingView = UIView()
        loadingView.autoSetDimensions(to: CGSize(width: 80, height: 60))
        loadingView.backgroundColor = .black
        loadingView.alpha = 0.7
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        return loadingView
    }()

    private let spinnerIndicatorView: UIActivityIndicatorView = {
        let spinnerIndicatorView = UIActivityIndicatorView(style: .medium)
        spinnerIndicatorView.color = .white
        return spinnerIndicatorView
    }()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 32, bottom: 10, right: 32)

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        layout()
        style()
    }

    private func getAlbums(withTitle title: String) {
        guard DeviceManager.isConnectedToNetwork else {
            presentNoWiFiConnectionAlert()
            return
        }

        startLoading()
        NetworkService.shared.fetchAlbums(withTitle: title) { [weak self] result in

            switch result {
            case .success(var albums):
                PersistenceManager.shared.addSearchedAlbum(title)
                albums = Album.removeDuplicateAlbums(albums).sorted { $0.collectionName < $1.collectionName }
                self?.albums = albums
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }
        }
    }

    private func setup() {
        navigationItem.title = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        collectionView.register(SearchAlbumCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        collectionView.dataSource = self
        collectionView.delegate = self

        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "e. g. Frank Sinatra"
        searchController.searchBar.searchTextField.clearButtonMode = .never
    }

    private func layout() {
        view.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0))
    }

    private func style() {
        view.backgroundColor = .white
    }

    private func startLoading() {
        searchController.searchBar.isUserInteractionEnabled = false

        view.addSubview(loadingView)
        loadingView.autoCenterInSuperview()

        loadingView.addSubview(spinnerIndicatorView)
        spinnerIndicatorView.autoCenterInSuperview()

        spinnerIndicatorView.startAnimating()
    }

    private func stopLoading() {
        spinnerIndicatorView.stopAnimating()
        loadingView.removeFromSuperview()
        searchController.searchBar.isUserInteractionEnabled = true
    }

    private func presentNoWiFiConnectionAlert() {
        let alert = UIAlertController(
            title: "No internet connection",
            message: "Please turn on Wi-Fi",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Open settings", style: .default) { _ in

            if let url = URL(string: UIApplication.openSettingsURLString),
               UIApplication.shared.canOpenURL(url) {
                   UIApplication.shared.open(url, options: [:])
            }
        })

        alert.addAction(UIAlertAction(title: "Nope", style: .cancel))

        present(alert, animated: true)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension SearchAlbumsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! SearchAlbumCollectionViewCell
        cell.contentView.backgroundColor = .imagePlaceholderColor
        cell.set(with: URL(string: albums[indexPath.row].artworkURL))

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let albumDetailsViewController = AlbumInfoViewController(selectedAlbum: albums[indexPath.row])
        navigationController?.pushViewController(albumDetailsViewController, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 40, height: collectionView.frame.width / 2 - 40)
    }
}

// MARK: - UISearchBarDelegate
extension SearchAlbumsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        getAlbums(withTitle: query)
        searchController.isActive = false
        searchBar.text = query
    }
}

// MARK: - SearchHistoryViewControllerDelegate
extension SearchAlbumsViewController: SearchHistoryViewControllerDelegate {
    func searchHistoryViewControllerDidSelectSearchedAlbum(withTitle title: String) {
        navigationController?.popToRootViewController(animated: true)
        getAlbums(withTitle: title)
    }
}
