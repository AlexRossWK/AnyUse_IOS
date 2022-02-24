//
//  Modifieble.swift
//  UIRelationship
//
//  Created by Alexey Rossoshansky on 01.07.2021.
//

import UIKit

public protocol Modifiable {
    var priority: UILayoutPriority { get set }
    
    var format: NSLayoutConstraint.Relation { get set }
    
    // MARK: - Have default implementations
    
    /// Возвращает настроеный экземпляр констрейнта таким образом, что
    /// значением distance может быть равным или меньше указанного
    var lessOrEqual: Self { get }
    
    /// Возвращает настроеный экземпляр констрейнта таким образом, что
    /// значением distance может быть равным или больше указанного
    var greaterOrEqual: Self { get }
    
    /// Возвращает настроеный экземпляр констрейнта таким образом, что
    /// приоритет констрейнта установлен как низкий
    /// (по умолчанию - required)
    var lowPriority: Self { get }
    
    /// Возвращает настроеный экземпляр констрейнта таким образом, что
    /// приоритет констрейнта установлен как средний
    /// (по умолчанию - required)
    var highPriority: Self { get }
}

public extension Modifiable {
    var lessOrEqual: Self {
        withNewFormat(.lessThanOrEqual)
    }
    
    var greaterOrEqual: Self {
        withNewFormat(.greaterThanOrEqual)
    }
    
    var lowPriority: Self {
        priority(.defaultLow)
    }
    
    var highPriority: Self {
        priority(.defaultHigh)
    }
    
    private func priority(_ priority: UILayoutPriority) -> Self {
        var mSelf = self
        mSelf.priority = priority
        return mSelf
    }
    
    private func withNewFormat(_ newFormat: NSLayoutConstraint.Relation) -> Self {
        var mSelf = self
        mSelf.format = newFormat
        return mSelf
    }
}

extension Modifiable {
    func getStraightConstraint<AnchorType, Anchor: NSLayoutAnchor<AnchorType>>(
        first: Anchor,
        relateTo second: Anchor,
        distance: CGFloat
    ) -> NSLayoutConstraint {
        switch format {
        case .equal:
            return first.constraint(equalTo: second, constant: distance)
        case .greaterThanOrEqual:
            return first.constraint(greaterThanOrEqualTo: second, constant: distance)
        case .lessThanOrEqual:
            return first.constraint(lessThanOrEqualTo: second, constant: distance)
#if swift(>=5.0)
        @unknown default:
            assert(false)
            return first.constraint(equalTo: second, constant: distance)
#endif
        }
    }
    
    func getReversedConstraint<AnchorType, Anchor: NSLayoutAnchor<AnchorType>>(
        first: Anchor,
        relateTo second: Anchor,
        distance: CGFloat
    ) -> NSLayoutConstraint {
        switch format {
        case .equal:
            return first.constraint(equalTo: second, constant: distance)
        case .greaterThanOrEqual:
            return first.constraint(lessThanOrEqualTo: second, constant: distance)
        case .lessThanOrEqual:
            return first.constraint(greaterThanOrEqualTo: second, constant: distance)
#if swift(>=5.0)
        @unknown default:
            assert(false)
            return first.constraint(equalTo: second, constant: distance)
#endif
        }
    }
}
