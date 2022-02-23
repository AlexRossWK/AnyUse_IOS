//
//  CornerRadius.swift
//  UIRelationship
//
//  Created by Alexey Rossoshansky on 15.12.2020.
//

import UIKit

/// Скругляет края вьюхи на указанный радиус
public struct RNCornerRadius: UIRelation {
    private let value: CGFloat

    public init(_ value: CGFloat) {
        self.value = value
    }

    public func addConstraint(to view: UIView, superview: UIView) {
        view.layer.cornerRadius = value
        view.clipsToBounds = true
    }
}
