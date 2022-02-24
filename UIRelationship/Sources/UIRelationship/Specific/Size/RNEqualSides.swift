//
//  RNEqualSides.swift
//  Currencies
//
//  Created by Alexey Rossoshansky on 29.05.2020.
//

import UIKit

public struct RNEqualSides: UIRelation {
    public let constant: CGFloat
    
    public init(constant: CGFloat) {
        self.constant = constant
    }
    
    public func addConstraint(to view: UIView, superview: UIView) {
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: constant),
            view.heightAnchor.constraint(equalToConstant: constant)
        ])
    }
}
