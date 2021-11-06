//
//  AlbumInfoRowView.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 1/14/21.
//

import UIKit

final class AlbumInfoRowView: UIView {

    enum TextType {
        case url
        case text
    }

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "—"
        titleLabel.font = .boldSystemFont(ofSize: 26)
        return titleLabel
    }()

    private let subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.text = "—"
        subtitleLabel.font = subtitleLabel.font.withSize(18)
        return subtitleLabel
    }()

    init(frame: CGRect = .zero, title: String, subtitle: String, textType: TextType = .text) {
        super.init(frame: frame)
        setup(title: title, subtitle: subtitle, textType: textType)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. No storyboards")
    }

    private func setup(title: String, subtitle: String, textType: TextType) {
        titleLabel.text = title
        subtitleLabel.text = subtitle

        guard textType == .url else {
            return
        }

        subtitleLabel.highlightAndUnderline(subtitle)
        let tap = UITapGestureRecognizer(target: self, action: #selector(onLinkTap))
        subtitleLabel.isUserInteractionEnabled = true
        subtitleLabel.addGestureRecognizer(tap)
    }
    
    private func layout() {
        let verticalStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        verticalStackView.alignment = .leading
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fill
        verticalStackView.spacing = 4

        addSubview(verticalStackView)
        verticalStackView.autoPinEdgesToSuperviewEdges()
    }

    @objc private func onLinkTap() {
        guard let url = URL(string: subtitleLabel.text ?? "") else { return }
        UIApplication.shared.open(url)
    }
}
