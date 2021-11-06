//
//  UIView+Shadow.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 11/6/21.
//

import Foundation
import UIKit

extension UIView {
    func dropShadow(color: UIColor = .black, opacity: Float = 1, offSet: CGSize = .zero, radius: CGFloat = 2) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
    }
}
