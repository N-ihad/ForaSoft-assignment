//
//  InfoView.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 1/14/21.
//


import UIKit

class InfoView: UIView {
    
    // MARK: - Properties
    
    private let captionLabel: UILabel = {
        let captionLabel = UILabel()
        captionLabel.text = "—"
        captionLabel.font = UIFont.boldSystemFont(ofSize: 26)
        
        return captionLabel
    }()
    
    let textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "—"
        textLabel.font = textLabel.font.withSize(18)
        
        return textLabel
    }()
    
    // MARK: - Lifecycle
    
    init(frame: CGRect = .zero, caption: String, text: String, textType: TextType = .text) {
        super.init(frame: frame)
        captionLabel.text = caption
        textLabel.text = text
        
        configureCaptionLabel(text: text, textType: textType)
        
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func albumLinkTapped() {
        print("something")
        guard let url = URL(string: textLabel.text ?? "") else { return }
        print("something happeneing")
        UIApplication.shared.open(url)
    }
    
    // MARK: - Helpers
    
    func configureCaptionLabel(text: String, textType: TextType) {
        guard textType == .url else { return }
        textLabel.highlightAndUnderline(searchedText: text)
        let tap = UITapGestureRecognizer(target: self, action: #selector(albumLinkTapped))
        textLabel.isUserInteractionEnabled = true
        textLabel.addGestureRecognizer(tap)
    }
    
    func configureSubviews() {
        let vStack = UIStackView(arrangedSubviews: [captionLabel, textLabel])
        vStack.alignment = .leading
        vStack.axis = .vertical
        vStack.distribution = .fill
        vStack.spacing = 4

        addSubview(vStack)
        vStack.autoPinEdgesToSuperviewEdges()
    }
}

extension InfoView {
    enum TextType {
        case url
        case text
    }
}
