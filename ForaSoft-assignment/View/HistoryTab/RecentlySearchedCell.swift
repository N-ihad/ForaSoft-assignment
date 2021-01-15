//
//  RecentlySearchedCell.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 1/15/21.
//

import UIKit

protocol RecentlySearchedCellDelegate: class {
    func didTapDeleteButton(_ cell: RecentlySearchedCell)
}

class RecentlySearchedCell: UITableViewCell {
    
    // MARK: - Properties
    
    weak var delegate: RecentlySearchedCellDelegate?
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        return titleLabel
    }()
    
    private lazy var deleteButton: UIButton = {
        let deleteButton = UIButton()
        deleteButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        deleteButton.tintColor = .red
        
        return deleteButton
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func deleteButtonTapped() {
        delegate?.didTapDeleteButton(self)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        configureSubviews()
    }
    
    func configureSubviews() {
        contentView.addSubview(titleLabel)
        titleLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 24)
        
        contentView.addSubview(deleteButton)
        deleteButton.autoAlignAxis(toSuperviewAxis: .horizontal)
        deleteButton.autoPinEdge(toSuperviewEdge: .right, withInset: 24)
    }
    
    func set(with title: String) {
        self.titleLabel.text = title
    }
    
}

