//
//  RNHuggingPriority.swift
//  UIRelationship
//
//  Created by Alexey Rossoshansky on 25.11.2021.
//

import Foundation
import UIKit

/// Задает вертикальный contentHuggingPriority
public struct RNVerticalHugging: UIRelation {
    private var priority: UILayoutPriority
    
    public init(_ priority: UILayoutPriority) {
        self.priority = priority
    }
    
    public func addConstraint(to view: UIView, superview: UIView) {
        view.setContentHuggingPriority(priority, for: .vertical)
    }
}

/// Задает горизонтальный contentHuggingPriority
public struct RNHorizontalHugging: UIRelation {
    private var priority: UILayoutPriority
    
    public init(_ priority: UILayoutPriority) {
        self.priority = priority
    }

    public func addConstraint(to view: UIView, superview: UIView) {
        view.setContentHuggingPriority(priority, for: .horizontal)
    }
}
