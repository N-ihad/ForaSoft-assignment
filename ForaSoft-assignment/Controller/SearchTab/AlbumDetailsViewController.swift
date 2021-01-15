//
//  AlbumDetailsViewController.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 1/14/21.
//

import UIKit

class AlbumDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    private let albumDetailsView = AlbumDetailsView()
    
    // MARK: - Lifecycle
    
    init(album: Album) {
        super.init(nibName: nil, bundle: nil)
        
        albumDetailsView.fields = album.detailsDescription
        albumDetailsView.artworkImageView.kf.setImage(with: URL(string: album.artworkURL))
        albumDetailsView.albumTitleLabel.text = album.collectionName
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNavBar()
    }
    
    // MARK: - Helpers
    
    func configureNavBar() {
        navigationItem.title = "Details"
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        configureSubviews()
    }
    
    func configureSubviews() {
        view.addSubview(albumDetailsView)
        albumDetailsView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 24)
        albumDetailsView.autoAlignAxis(toSuperviewAxis: .vertical)
        albumDetailsView.autoPinEdge(toSuperviewSafeArea: .bottom)
    }
    
}
