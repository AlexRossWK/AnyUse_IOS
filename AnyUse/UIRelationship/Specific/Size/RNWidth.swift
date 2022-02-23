//
//  RNWidth.swift
//  Currencies
//
//  Created by Alexey Rossoshansky on 29.05.2020.
//

import UIKit

public struct RNWidth: UIRelation {
    private let constant: CGFloat
    private let otherView: UIView?
    
    public init(_ constant: CGFloat) {
        self.constant = constant
        self.otherView = nil
    }
    
    public init(as otherView: UIView, constant: CGFloat = 0) {
        self.constant = constant
        self.otherView = otherView
    }
    
    public func addConstraint(to view: UIView, superview: UIView) {
        if let otherView = self.otherView {
            view.widthAnchor.constraint(
                equalTo: otherView.widthAnchor,
                constant: self.constant)
            .isActive = true
        } else {
            view.widthAnchor.constraint(
                equalToConstant: constant)
            .isActive = true
        }
    }
}
