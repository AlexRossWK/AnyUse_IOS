//
//  RNLeftToSuperview.swift
//  Currencies
//
//  Created by Alexey Rossoshansky on 29.05.2020.
//

import UIKit

public struct RNLeftToSuperview: UIRelation, Modifiable {
    
    public var priority: UILayoutPriority = .required
    
    public var format: NSLayoutConstraint.Relation = .equal
    
    private let distance: CGFloat
    
    public init(distance: CGFloat = 0) {
        self.distance = distance
    }
    
    public func addConstraint(to view: UIView, superview: UIView) {
        buildStraightConstraint(
            firstAnchor: view.leadingAnchor,
            otherAnchor: superview.leadingAnchor,
            distance: distance
        )
    }
}
