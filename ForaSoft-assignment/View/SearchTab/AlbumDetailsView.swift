//
//  AlbumDetailsView.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 1/14/21.
//

import UIKit

class AlbumDetailsView: UIView {
    
    // MARK: - Properties
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    private let scrollViewContentView: UIView = {
        let scrollViewContentView = UIView()
        
        return scrollViewContentView
    }()
    
    let artworkImageView: UIImageView = {
        let artworkImageView = UIImageView()
        artworkImageView.autoSetDimensions(to: CGSize(width: 300, height: 300))
        artworkImageView.backgroundColor = .imagePlaceholderColor
        artworkImageView.dropShadow()
        
        return artworkImageView
    }()
    
    let albumTitleLabel: UILabel = {
        let albumTitleLabel = UILabel()
        albumTitleLabel.text = "—"
        albumTitleLabel.font = UIFont.boldSystemFont(ofSize: 26)
        albumTitleLabel.textAlignment = .center
        albumTitleLabel.numberOfLines = 1
        albumTitleLabel.lineBreakMode = .byTruncatingTail
        albumTitleLabel.autoSetDimension(.width, toSize: 300)
        
        return albumTitleLabel
    }()
    
    lazy var fields: [(String, String)] = [] {
        willSet(newFields) {
            let vStack = UIStackView()
            vStack.alignment = .leading
            vStack.axis = .vertical
            vStack.distribution = .fill
            vStack.spacing = 14

            for (caption, text) in newFields {
                let infoView = InfoView(frame: .zero,
                                        caption: caption,
                                        text: text,
                                        textType: caption == "Artwork URL" ? .url : .text)
                vStack.addArrangedSubview(infoView)
            }
            scrollViewContentView.addSubview(vStack)
            vStack.autoPinEdge(.top, to: .bottom, of: albumTitleLabel, withOffset: 18)
            vStack.autoPinEdge(.left, to: .left, of: scrollViewContentView, withOffset: 18)
            vStack.autoPinEdge(.right, to: .right, of: scrollViewContentView, withOffset: -12)
            vStack.autoPinEdge(.bottom, to: .bottom, of: scrollViewContentView, withOffset: -18)
        }
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        autoSetDimension(.width, toSize: UIScreen.main.bounds.width)
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureSubviews() {
        addSubview(scrollView)
        scrollView.autoPinEdgesToSuperviewEdges()
        
        scrollView.addSubview(scrollViewContentView)
        scrollViewContentView.autoPinEdgesToSuperviewEdges()
        scrollViewContentView.autoMatch(.width, to: .width, of: scrollView)
        
        scrollViewContentView.addSubview(artworkImageView)
        artworkImageView.autoAlignAxis(toSuperviewAxis: .vertical)
        artworkImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 12)
        
        scrollViewContentView.addSubview(albumTitleLabel)
        albumTitleLabel.autoPinEdge(.top, to: .bottom, of: artworkImageView, withOffset: 15)
        albumTitleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
    }
    
}


