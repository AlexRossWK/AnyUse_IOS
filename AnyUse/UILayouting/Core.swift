//
//  Core.swift
//  AnyUse
//
//  Created by Алексей on 22..022022.
//

import UIKit

infix operator =>: MultiplicationPrecedence
infix operator =>>: MultiplicationPrecedence

public extension NSLayoutConstraint {
    func activated() -> Self {
        isActive = true
        return self
    }
    
    @discardableResult
    static func + (lhs: NSLayoutConstraint, rhs: CGFloat) -> NSLayoutConstraint {
        lhs.constant += rhs
        return lhs
    }
    
    @discardableResult
    static func - (lhs: NSLayoutConstraint, rhs: CGFloat) -> NSLayoutConstraint {
        lhs.constant -= rhs
        return lhs
    }
}

public extension NSLayoutXAxisAnchor {
    @discardableResult
    static func => (lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
        lhs.constraint(equalTo: rhs).activated()
    }
    
    @discardableResult
    static func =>> (lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
        lhs.constraint(greaterThanOrEqualTo: rhs).activated()
    }
}

public extension NSLayoutYAxisAnchor {
    @discardableResult
    static func => (lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
        lhs.constraint(equalTo: rhs).activated()
    }
    
    @discardableResult
    static func =>> (lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
        lhs.constraint(greaterThanOrEqualTo: rhs).activated()
    }
}

public extension NSLayoutDimension {
    @discardableResult
    static func => (lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
        lhs.constraint(equalTo: rhs).activated()
    }
    
    @discardableResult
    static func => (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
        lhs.constraint(equalToConstant: rhs).activated()
    }
    
    @discardableResult
    static func =>> (lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
        lhs.constraint(greaterThanOrEqualTo: rhs).activated()
    }
    
    @discardableResult
    static func =>> (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
        lhs.constraint(greaterThanOrEqualToConstant: rhs).activated()
    }
}
