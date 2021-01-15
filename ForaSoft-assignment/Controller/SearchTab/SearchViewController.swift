//
//  SearchViewController.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 1/13/21.
//

import UIKit
import PureLayout

private let reuseIdentifier = "cell"

class SearchViewController: UIViewController {
    
    // MARK: - Properties
    
    let searchController = UISearchController(searchResultsController: nil)
    private var albums = [Album]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.removeLoadingView()
            }
        }
    }
    
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
        let spinnerIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureCollectionView()
        configureSearchBar()
//        fetchAlbums(with: "Frank Sinatra")
    }
    
    // MARK: - API
    
    func fetchAlbums(with title: String) {
        guard DeviceManager.isConnectedToNetwork() else { presentNoWiFiAlert(); return }
        
        DispatchQueue.main.async {
            self.showLoadingView()
        }
        
        DispatchQueue.global(qos: .utility).async {
            NetworkManager.shared.fetchSearchResult(query: title, completion: { [weak self] result in
                DispatchQueue.global(qos: .utility).async {
                    guard let self = self else { return }
                    switch result {
                    case .success(var albums):
                        BackendManager.shared.addQueryToRealmDB(query: title)
                        albums = Album.removeDuplicateAlbums(albums)
                        albums.sort { $0.collectionName < $1.collectionName }
                        self.albums = albums
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            })
        }
    }
    
    // MARK: - Helpers
    
    func configureNavBar() {
        navigationItem.title = "Search"
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        configureNavBar()
        configureSubviews()
    }
    
    func configureSubviews() {
        view.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0))
    }
    
    func configureCollectionView() {
        collectionView.register(AlbumCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func configureSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "e. g. Frank Sinatra"
    }
    
    func showLoadingView() {
        view.addSubview(loadingView)
        loadingView.autoCenterInSuperview()

        loadingView.addSubview(spinnerIndicatorView)
        spinnerIndicatorView.autoCenterInSuperview()
        
        spinnerIndicatorView.startAnimating()
    }

    func removeLoadingView() {
        spinnerIndicatorView.stopAnimating()
        loadingView.removeFromSuperview()
    }
    
}

// MARK: - UICollectionViewDelegate / UICollectionViewDataSource / UICollectionViewDelegateFlowLayout

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AlbumCell
        cell.contentView.backgroundColor = .imagePlaceholderColor

        cell.set(with: URL(string: albums[indexPath.row].artworkURL))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let albumDetailsViewController = AlbumDetailsViewController(album: albums[indexPath.row])
        navigationController?.pushViewController(albumDetailsViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - 40, height: collectionView.frame.width/2 - 40)
    }
    
    func presentNoWiFiAlert() {
        let alert = UIAlertController(title: "No internet connection", message: "Please turn on Wi-Fi", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Go to the settings", style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(url) {
                   UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        })
        alert.addAction(UIAlertAction(title: "Nope", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UISearchBarDelegate /

extension SearchViewController: UISearchBarDelegate, UISearchControllerDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        fetchAlbums(with: searchText)
        searchController.searchBar.resignFirstResponder()
    }
}

// MARK: - HistoryViewControllerDelegate

extension SearchViewController: HistoryViewControllerDelegate {
    func didSelectRow(with title: String) {
        fetchAlbums(with: title)
    }
}
