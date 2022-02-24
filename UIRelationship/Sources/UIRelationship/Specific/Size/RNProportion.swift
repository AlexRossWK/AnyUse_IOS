//
//  RNProportion.swift
//  UIRelationship
//
//  Created by Alexey Rossoshansky on 16.02.2021.
//

import UIKit

/// Указывает на отношение ширины к высоте или высоты к ширине
public struct RNProportion: UIRelation {
    private let width: CGFloat?
    private let height: CGFloat?
    
    /// Указывает соотношение ширины к высоте
    /// Например widthToHeight: 0.5 означает что ширина будет в 2 раза меньше чем высота
    public init(widthToHeight: CGFloat) {
        self.width = widthToHeight
        self.height = nil
    }
    
    /// Указывает соотношение высоты к ширине
    /// Например heightToWidth: 0.5 означает что высота будет в 2 раза меньше ширины
    public init(heightToWidth: CGFloat) {
        self.width = nil
        self.height = heightToWidth
    }
    
    public func addConstraint(to view: UIView, superview: UIView) {
        if let widthScale = self.width {
            view.widthAnchor.constraint(
                equalTo: view.heightAnchor,
                multiplier: widthScale
            ).isActive = true
        }
        
        if let heightScale = self.height {
            view.heightAnchor.constraint(
                equalTo: view.widthAnchor,
                multiplier: heightScale
            ).isActive = true
        }
    }
}
