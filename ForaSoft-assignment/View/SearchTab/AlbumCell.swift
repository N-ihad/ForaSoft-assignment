//
//  AlbumCell.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 1/14/21.
//

import UIKit
import Kingfisher

class AlbumCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let artworkImageView: UIImageView = {
        let artworkImageView = UIImageView()
        artworkImageView.contentMode = .scaleAspectFill
        
        return artworkImageView
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        configureSubviews()
    }
    
    func configureSubviews() {
        contentView.addSubview(artworkImageView)
        artworkImageView.autoPinEdgesToSuperviewEdges()
    }
    
    func set(with artworkURL: URL?) {
        self.artworkImageView.kf.setImage(with: artworkURL)
    }
    
}
