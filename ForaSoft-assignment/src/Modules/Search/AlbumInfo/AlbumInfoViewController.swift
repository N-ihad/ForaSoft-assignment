//
//  AlbumInfoViewController.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 1/14/21.
//

import UIKit

final class AlbumInfoViewController: UIViewController {

    private let albumInfoRowsView = AlbumInfoRowsView()

    init(selectedAlbum album: Album) {
        super.init(nibName: nil, bundle: nil)
        albumInfoRowsView.rows = album.detailsDescription
        albumInfoRowsView.artworkImageView.kf.setImage(with: URL(string: album.artworkURL))
        albumInfoRowsView.albumTitleLabel.text = album.collectionName
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. No storyboards")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
        style()
    }

    private func setup() {
        navigationItem.title = "Details"
    }

    private func layout() {
        view.addSubview(albumInfoRowsView)
        albumInfoRowsView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 24)
        albumInfoRowsView.autoAlignAxis(toSuperviewAxis: .vertical)
        albumInfoRowsView.autoPinEdge(toSuperviewSafeArea: .bottom)
    }

    private func style() {
        view.backgroundColor = .white
    }
}
