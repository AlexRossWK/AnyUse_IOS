//
//  UIView+Descedant.swift
//  AnyUse
//
//  Created by Алексей on 22..022022.
//

import UIKit

extension UIView {
    /// Utilizes BFS to find first descendant of the specified type
    @inlinable
    public func firstDescendant<T>(of type: T.Type) -> T? {
        var queueTree = [self]
        
        while !queueTree.isEmpty {
            let current = queueTree.remove(at: 0)
            if let result = current as? T {
                return result
            }
            if !current.subviews.isEmpty {
                for tree in current.subviews {
                    queueTree.append(tree)
                }
            }
        }
        
        return nil
    }
    
    /// Utilizes BFS to find first descendant which satisfies the predicate
    @inlinable
    public func firstDescendant(where predicate: (UIView) throws -> Bool) rethrows -> UIView? {
        var queueTree = [self]
        while !queueTree.isEmpty {
            let current = queueTree.remove(at: 0)
            if try predicate(current) {
                return current
            }
            if !current.subviews.isEmpty {
                for tree in current.subviews {
                    queueTree.append(tree)
                }
            }
        }
        
        return nil
    }
}
