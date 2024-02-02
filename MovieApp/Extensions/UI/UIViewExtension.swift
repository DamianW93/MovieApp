//
//  UIViewExtension.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 22/01/2024.
//

import UIKit

extension UIView {
    func dropShadow(scale: Bool = true, shadowRadius: CGFloat = 1) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = shadowRadius
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
