//
//  AlbumInfoRowsView.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 1/14/21.
//

import UIKit

final class AlbumInfoRowsView: UIView {

    private let scrollView = UIScrollView()
    private let scrollViewContentView = UIView()

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
        albumTitleLabel.font = .boldSystemFont(ofSize: 26)
        albumTitleLabel.textAlignment = .center
        albumTitleLabel.lineBreakMode = .byTruncatingTail
        albumTitleLabel.autoSetDimension(.width, toSize: 300)
        return albumTitleLabel
    }()

    lazy var rows: [(String, String)] = [] {
        willSet(newFields) {
            let verticalStackView = UIStackView()
            verticalStackView.alignment = .leading
            verticalStackView.axis = .vertical
            verticalStackView.distribution = .fill
            verticalStackView.spacing = 14

            for (title, subtitle) in newFields {
                let infoView = AlbumInfoRowView(
                    frame: .zero,
                    title: title,
                    subtitle: subtitle,
                    textType: title == "Artwork URL" ? .url : .text
                )
                verticalStackView.addArrangedSubview(infoView)
            }

            scrollViewContentView.addSubview(verticalStackView)
            verticalStackView.autoPinEdge(.top, to: .bottom, of: albumTitleLabel, withOffset: 18)
            verticalStackView.autoPinEdge(.left, to: .left, of: scrollViewContentView, withOffset: 18)
            verticalStackView.autoPinEdge(.right, to: .right, of: scrollViewContentView, withOffset: -12)
            verticalStackView.autoPinEdge(.bottom, to: .bottom, of: scrollViewContentView, withOffset: -18)
        }
    }

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. No storyboards")
    }

    private func layout() {
        autoSetDimension(.width, toSize: UIScreen.main.bounds.width)

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
