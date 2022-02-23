//
//  RNEdgesToSuperview.swift
//  Currencies
//
//  Created by Alexey Rossoshansky on 29.05.2020.
//

import UIKit

public struct RNEdgesToSuperview: UIRelation {
    let inset: CGFloat
    
    public init(inset: CGFloat = 0) {
        self.inset = inset
    }
    
    public func addConstraint(to view: UIView, superview: UIView) {
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: inset),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -inset),
            view.topAnchor.constraint(equalTo: superview.topAnchor, constant: inset),
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -inset)
        ])
    }
}
