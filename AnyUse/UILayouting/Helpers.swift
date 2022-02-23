//
//  Helpers.swift
//  AnyUse
//
//  Created by Алексей on 22..022022.
//

import UIKit

public extension UIView {
    var top: NSLayoutYAxisAnchor { topAnchor }
    var bottom: NSLayoutYAxisAnchor { bottomAnchor }
    var left: NSLayoutXAxisAnchor { leftAnchor }
    var right: NSLayoutXAxisAnchor { rightAnchor }
    var height: NSLayoutDimension { heightAnchor }
    var width: NSLayoutDimension { widthAnchor }
    var centerY: NSLayoutYAxisAnchor { centerYAnchor }
    var centerX: NSLayoutXAxisAnchor { centerXAnchor }
}

public extension UIView {
    func forAutolayout() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func placedOn(_ parent: UIView) -> Self {
        parent.addSubview(self.forAutolayout())
        return self
    }
    
    func pinToCenter(of view: UIView) {
        self.centerX => view.centerX
        self.centerY => view.centerY
    }
    
    @discardableResult
    func pinToSides(of view: UIView, insets: UIEdgeInsets = .zero) -> (top: NSLayoutConstraint, right: NSLayoutConstraint, left: NSLayoutConstraint, bottom: NSLayoutConstraint) {
        (
            self.top => view.top + insets.top,
            self.left => view.left + insets.left,
            self.right => view.right - insets.right,
            self.bottom => view.bottom - insets.bottom
        )
    }
}
