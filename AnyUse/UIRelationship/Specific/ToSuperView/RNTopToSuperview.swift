//
//  RNTopToSuperview.swift
//  Currencies
//
//  Created by Alexey Rossoshansky on 29.05.2020.
//

import UIKit

public class RNTopToSafeAreaSuperview: RNTopToSuperview {
    public override func addConstraint(to view: UIView, superview: UIView) {
        if #available(iOS 11.0, *) {
            constraint = view.topAnchor.constraint(
                equalTo: superview.safeAreaLayoutGuide.topAnchor,
                constant: constant)
            constraint?.isActive = true
        } else {
            super.addConstraint(to: view, superview: superview)
        }
    }
}

public class RNTopToSuperview: UIMutableRelation, Modifiable {
    public var priority: UILayoutPriority = .required
    
    public var format: NSLayoutConstraint.Relation = .equal
    
    fileprivate let constant: CGFloat
    fileprivate var constraint: NSLayoutConstraint?
    
    public init(distance: CGFloat = 0) {
        self.constant = distance
    }
    
    public func addConstraint(to view: UIView, superview: UIView) {
        buildStraightConstraint(
            firstAnchor: view.topAnchor,
            otherAnchor: superview.topAnchor,
            distance: constant
        )
    }
    
    public func updateConstant(_ newValue: CGFloat) {
        constraint?.constant = newValue
    }
}
