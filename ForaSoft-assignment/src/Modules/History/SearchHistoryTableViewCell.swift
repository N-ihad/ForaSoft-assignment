//
//  SearchedAlbumsTableViewCell.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 1/15/21.
//

import UIKit

protocol SearchHistoryTableViewCellDelegate: AnyObject {
    func searchHistoryTableViewCellDidReceiveDeleteTap(_ cell: SearchHistoryTableViewCell, title: String)
}

final class SearchHistoryTableViewCell: UITableViewCell {

    weak var delegate: SearchHistoryTableViewCellDelegate?

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 18)
        return titleLabel
    }()

    private lazy var deleteButton: UIButton = {
        let deleteButton = UIButton()
        deleteButton.setImage(.delete, for: .normal)
        deleteButton.addTarget(self, action: #selector(onDelete), for: .touchUpInside)
        deleteButton.tintColor = .red
        return deleteButton
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. No storyboards")
    }

    private func layout() {
        contentView.addSubview(titleLabel)
        titleLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 24)
        
        contentView.addSubview(deleteButton)
        deleteButton.autoAlignAxis(toSuperviewAxis: .horizontal)
        deleteButton.autoPinEdge(toSuperviewEdge: .right, withInset: 24)
    }

    @objc private func onDelete() {
        guard let title = titleLabel.text else {
            return
        }
        delegate?.searchHistoryTableViewCellDidReceiveDeleteTap(self, title: title)
    }

    func set(withTitle title: String) {
        titleLabel.text = title
    }
}
