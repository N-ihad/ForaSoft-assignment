//
//  Extensions.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 1/14/21.
//

import UIKit


// MARK: - UIView

extension UIView {
    func dropShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 2
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
    }
}

// MARK: - UIColor

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func rgba(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    static let imagePlaceholderColor = rgb(red: 238, green: 238, blue: 238)
}

// MARK: - UILabel

extension UILabel {
    func highlightAndUnderline(searchedText: String, color: UIColor = .systemBlue) {
        guard let txtLabel = self.text else {return}
        let attributeTxt = NSMutableAttributedString(string: txtLabel)
        let range: NSRange = attributeTxt.mutableString.range(of: searchedText.lowercased(), options: .caseInsensitive)

        attributeTxt.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        attributeTxt.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: range)

        self.attributedText = attributeTxt
    }
}
