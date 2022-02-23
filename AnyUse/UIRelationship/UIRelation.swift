//
//  UIRelation.swift
//  Currencies
//
//  Created by Alexey Rossoshansky on 29.05.2020.
//

import UIKit

// MARK: -

public extension UIView {
    // swiftlint:disable attributes
    /// Добавляет логику отношений между вьюхами.
    /// - Parameter relations: Кложура-билдер, для всех видов отношений между вьюхами
    /// - Returns: этот же экземпляр вьюхи, у которого был вызван этот метод
    @discardableResult
    func placeRelations(@RelationBuilder _ relations: () -> UIRelation) -> Self {
        guard let superview = self.superview else {
            assertionFailure("UIView должно иметь superview прежде чем начать установку констрейнтов")
            return self
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        relations().addConstraint(to: self, superview: superview)
        return self
    }
}

// MARK: -

public protocol UIRelation {
    func addConstraint(to view: UIView, superview: UIView)
}

public protocol UIMutableRelation: UIRelation {
    func updateConstant(_ newValue: CGFloat)
}

// MARK: -

@resultBuilder
public enum RelationBuilder {
    public static func combine(@RelationBuilder relations: () -> UIRelation) -> UIRelation {
        relations()
    }
    
    public static func buildBlock(_ segments: UIRelation...) -> UIRelation {
        segments.count == 1
            ? segments[0]
            : RNComplexRelation(with: segments)
    }
}

// MARK: - Private

private struct RNComplexRelation: UIRelation {
    let relations: [UIRelation]
    
    init(with newRelations: [UIRelation]) {
        self.relations = newRelations
    }
    
    func with(newRelations: UIRelation...) -> RNComplexRelation {
        let targetRelations = self.relations + newRelations
        return RNComplexRelation(with: targetRelations)
    }
    
    func buildConstraints(forView view: UIView, superview: UIView) {
        self.relations.forEach {
            $0.addConstraint(to: view, superview: superview)
        }
    }
    
    func addConstraint(to view: UIView, superview: UIView) {
        self.buildConstraints(forView: view, superview: superview)
    }
}

extension UIRelation where Self: Modifiable {
    func buildStraightConstraint<AnchorType, Anchor: NSLayoutAnchor<AnchorType>>(
        firstAnchor: Anchor,
        otherAnchor: Anchor,
        distance: CGFloat
    ) {
        let constraint = getStraightConstraint(
            first: firstAnchor,
            relateTo: otherAnchor,
            distance: distance
        )
        constraint.priority = priority
        constraint.isActive = true
    }
    
    func buildReversedConstraint<AnchorType, Anchor: NSLayoutAnchor<AnchorType>>(
        firstAnchor: Anchor,
        otherAnchor: Anchor,
        distance: CGFloat
    ) {
        let constraint = getReversedConstraint(
            first: firstAnchor,
            relateTo: otherAnchor,
            distance: distance
        )
        constraint.priority = priority
        constraint.isActive = true
    }
}
