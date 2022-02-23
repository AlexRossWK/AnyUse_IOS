//
//  RNBottomToSuperview.swift
//  Currencies
//
//  Created by Alexey Rossoshansky on 29.05.2020.
//

import UIKit

public struct RNBottomToSafeAreaSuperview: UIRelation {
    private let distance: CGFloat
    
    public init(distance: CGFloat = 0) {
        self.distance = distance
    }
    
    public func addConstraint(to view: UIView, superview: UIView) {
        if #available(iOS 11.0, *) {
            view.bottomAnchor.constraint(
                equalTo: superview.safeAreaLayoutGuide.bottomAnchor,
                constant: -distance
            ).isActive = true
        }
    }
}

public struct RNBottomToSuperview: UIRelation, Modifiable {
    public var priority: UILayoutPriority = .required
    
    public var format: NSLayoutConstraint.Relation = .equal
    
    private let distance: CGFloat
    
    public init(distance: CGFloat = 0) {
        self.distance = distance
    }
    
    public func addConstraint(to view: UIView, superview: UIView) {
        buildReversedConstraint(
            firstAnchor: view.bottomAnchor,
            otherAnchor: superview.bottomAnchor,
            distance: -distance
        )
    }
}
