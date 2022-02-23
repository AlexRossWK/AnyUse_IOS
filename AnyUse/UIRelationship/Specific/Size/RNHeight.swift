//
//  RNHeight.swift
//  Currencies
//
//  Created by Alexey Rossoshansky on 29.05.2020.
//

import UIKit

public struct RNHeight: UIRelation {
    private let constant: CGFloat?
    private let otherView: UIView?
    
    public init(_ constant: CGFloat) {
        self.constant = constant
        self.otherView = nil
    }
    
    public init(as otherView: UIView) {
        self.constant = nil
        self.otherView = otherView
    }
    
    public func addConstraint(to view: UIView, superview: UIView) {
        if let constant = self.constant {
            view.heightAnchor.constraint(
                equalToConstant: constant)
            .isActive = true
        } else if let otherView = self.otherView {
            view.heightAnchor.constraint(
                equalTo: otherView.heightAnchor,
                multiplier: 1)
            .isActive = true
        }
    }
}
