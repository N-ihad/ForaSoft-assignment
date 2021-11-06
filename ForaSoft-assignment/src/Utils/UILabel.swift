//
//  UILabel.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 11/6/21.
//

import Foundation
import UIKit

extension UILabel {
    func highlightAndUnderline(_ substring: String, color: UIColor = .systemBlue) {
        guard let text = text else {
            return
        }

        let attributedText = NSMutableAttributedString(string: text)
        let range = attributedText.mutableString.range(of: substring.lowercased(), options: .caseInsensitive)

        attributedText.addAttribute(.foregroundColor, value: color, range: range)
        attributedText.addAttribute(.underlineStyle, value: 1, range: range)

        self.attributedText = attributedText
    }
}
