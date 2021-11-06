//
//  AlbumCollectionViewCell.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 1/14/21.
//

import UIKit
import Kingfisher

final class SearchAlbumCollectionViewCell: UICollectionViewCell {

    private let artworkImageView: UIImageView = {
        let artworkImageView = UIImageView()
        artworkImageView.contentMode = .scaleAspectFill
        return artworkImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. No storyboards")
    }

    private func layout() {
        contentView.addSubview(artworkImageView)
        artworkImageView.autoPinEdgesToSuperviewEdges()
    }

    func set(with artworkUrl: URL?) {
        artworkImageView.kf.setImage(with: artworkUrl)
    }
}
