//
//  RNCenterToView.swift
//  UIRelationship
//
//  Created by Alexey Rossoshansky on 17.09.2020.
//

import UIKit

public struct RNCenterYTo: UIRelation {
    private let distance: CGFloat
    private weak var otherView: UIView?
    
    public init(_ otherView: UIView, distance: CGFloat = 0) {
        self.distance = distance
        self.otherView = otherView
    }
    
    public func addConstraint(to view: UIView, superview: UIView) {
        guard let otherView = otherView else {
            return
        }
        view.centerYAnchor.constraint(
            equalTo: otherView.centerYAnchor,
            constant: distance
        ).isActive = true
    }
}

public struct RNCenterXTo: UIRelation {
    private let distance: CGFloat
    private weak var otherView: UIView?
    
    public init(_ otherView: UIView, distance: CGFloat = 0) {
        self.distance = distance
        self.otherView = otherView
    }
    
    public func addConstraint(to view: UIView, superview: UIView) {
        guard let otherView = otherView else {
            return
        }
        view.centerXAnchor.constraint(
            equalTo: otherView.centerXAnchor,
            constant: distance
        ).isActive = true
    }
}
