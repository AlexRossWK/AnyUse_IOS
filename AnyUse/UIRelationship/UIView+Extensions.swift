//
//  UIView+Extensions.swift
//  Currencies
//
//  Created by Alexey Rossoshansky on 25.05.2020.
//

import UIKit

public extension UIView {
    func located(on newSuperView: UIView) -> Self {
        newSuperView.addSubview(self)
        return self
    }
}


public protocol KeyPathWritable: UIView {
    
}

extension UIView: KeyPathWritable {  }

public extension KeyPathWritable {
    func with<T>(_ keyPath: ReferenceWritableKeyPath<Self, T>, of value: T) -> Self {
        self[keyPath: keyPath] = value
        return self
    }
}
