//
//  RNRightToSuperview.swift
//  Currencies
//
//  Created by Alexey Rossoshansky on 29.05.2020.
//

import UIKit

public struct RNRightToSuperview: UIRelation, Modifiable {
    public var priority: UILayoutPriority = .required
    
    public var format: NSLayoutConstraint.Relation = .equal
    
    private let distance: CGFloat
    
    public init(distance: CGFloat = 0) {
        self.distance = distance
    }
    
    public func addConstraint(to view: UIView, superview: UIView) {
        buildReversedConstraint(
            firstAnchor: view.trailingAnchor,
            otherAnchor: superview.trailingAnchor,
            distance: -distance
        )
    }
}
