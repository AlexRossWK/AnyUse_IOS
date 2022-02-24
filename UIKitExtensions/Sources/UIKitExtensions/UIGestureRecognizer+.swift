//
//  UIGestureRecognizer+.swift
//  AnyUse
//
//  Created by Алексей on 22..022022.
//

import UIKit

extension UIGestureRecognizer {
    public convenience init(handler: @escaping (Self) -> Void) {
        self.init(target: nil, action: nil)
        addTarget(self, action: #selector(handlerAction(sender:)))
        _handler = {
            handler($0 as! Self)
        }
    }
}

private var associatedObjectKey: UInt8 = 0

fileprivate extension UIGestureRecognizer {
    typealias Handler = (UIGestureRecognizer) -> Void
    
    var _handler: Handler? {
        get {
            (objc_getAssociatedObject(self, &associatedObjectKey) as! Handler)
        }
        set {
            objc_setAssociatedObject(self, &associatedObjectKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc
    func handlerAction(sender: UIGestureRecognizer) {
        _handler?(sender as! Self)
    }
}
