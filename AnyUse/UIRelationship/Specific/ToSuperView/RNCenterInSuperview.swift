//
//  RNCenterInSuperview.swift
//  UIRelationship
//
//  Created by Alexey Rossoshansky on 17.09.2020.
//

import UIKit

public struct RNCenterYSuperview: UIRelation {
    private let distance: CGFloat
    
    public init(distance: CGFloat = 0) {
        self.distance = distance
    }
    
    public func addConstraint(to view: UIView, superview: UIView) {
        view.centerYAnchor.constraint(
            equalTo: superview.centerYAnchor,
            constant: distance
        ).isActive = true
    }
}

public struct RNCenterXSuperview: UIRelation {
    private let distance: CGFloat
    
    public init(distance: CGFloat = 0) {
        self.distance = distance
    }
    
    public func addConstraint(to view: UIView, superview: UIView) {
        view.centerXAnchor.constraint(
            equalTo: superview.centerXAnchor,
            constant: distance
        ).isActive = true
    }
}
