//
//  RNTopToView.swift
//  Currencies
//
//  Created by Alexey Rossoshansky on 29.05.2020.
//

import UIKit

// MARK: -

public struct RNTopToBottomOf: UIRelation, Modifiable {
    public var priority: UILayoutPriority = .required
    
    public var format: NSLayoutConstraint.Relation = .equal
    
    private let otherView: UIView
    
    private let distance: CGFloat
    
    public init(_ otherView: UIView, distance: CGFloat = 0) {
        self.otherView = otherView
        self.distance = distance
    }
    
    public func addConstraint(to view: UIView, superview: UIView) {
        buildStraightConstraint(
            firstAnchor: view.topAnchor,
            otherAnchor: otherView.bottomAnchor,
            distance: distance
        )
    }
}

// MARK: -

public struct RNTopToTopOf: UIRelation, Modifiable {
    public var priority: UILayoutPriority = .required
    
    public var format: NSLayoutConstraint.Relation = .equal
    
    private let otherView: UIView
    private let distance: CGFloat
    
    public init(_ otherView: UIView, distance: CGFloat = 0) {
        self.otherView = otherView
        self.distance = distance
    }
    
    public func addConstraint(to view: UIView, superview: UIView) {
        buildStraightConstraint(
            firstAnchor: view.topAnchor,
            otherAnchor: otherView.topAnchor,
            distance: distance
        )
    }
}
