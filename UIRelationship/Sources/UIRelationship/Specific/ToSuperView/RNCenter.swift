//
//  RNCenter.swift
//  Currencies
//
//  Created by Alexey Rossoshansky on 29.05.2020.
//

import UIKit

// MARK: -

public struct RNCenterVerticalInSuperview: UIRelation {
    private let distance: CGFloat
    
    public init(distance: CGFloat = 0) {
        self.distance = distance
    }
    
    public func addConstraint(to view: UIView, superview: UIView) {
        view.centerYAnchor.constraint(
            equalTo: superview.centerYAnchor,
            constant: distance)
            .isActive = true
    }
}

// MARK: -

public struct RNCenterHorizontalInSuperview: UIRelation {
    private let distance: CGFloat
    
    public init(distance: CGFloat = 0) {
        self.distance = distance
    }
    
    public func addConstraint(to view: UIView, superview: UIView) {
        view.centerXAnchor.constraint(
            equalTo: superview.centerXAnchor,
            constant: distance)
            .isActive = true
    }
}
