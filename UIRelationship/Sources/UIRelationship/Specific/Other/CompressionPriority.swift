//
//  RNCompressionResistencePriority.swift
//  UIRelationship
//
//  Created by Alexey Rossoshansky on 25.11.2021.
//

import UIKit

/// Задает вертикальный compressionResistencePriority
public struct RNVerticalCompressionResistence: UIRelation {
    private var priority: UILayoutPriority
    
    public init(_ priority: UILayoutPriority) {
        self.priority = priority
    }

    public func addConstraint(to view: UIView, superview: UIView) {
        view.setContentCompressionResistancePriority(priority, for: .vertical)
    }
}

/// Задает горизонтальный compressionResistencePriority
public struct RNHorizontalCompressionResistence: UIRelation {
    private var priority: UILayoutPriority
    
    public init(_ priority: UILayoutPriority) {
        self.priority = priority
    }

    public func addConstraint(to view: UIView, superview: UIView) {
        view.setContentCompressionResistancePriority(priority, for: .horizontal)
    }
}
