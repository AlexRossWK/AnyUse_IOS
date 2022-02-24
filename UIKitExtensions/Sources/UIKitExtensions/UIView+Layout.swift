//
//  UIView+Layout.swift
//  AnyUse
//
//  Created by Алексей on 22..022022.
//

import UIKit

//extension UIView {
//    
//    @discardableResult
//    func addTo(_ view: UIView, index: Int? = nil) -> Self {
//        translatesAutoresizingMaskIntoConstraints = false
//        if let i = index {
//            view.insertSubview(self, at: i)
//        } else {
//            view.addSubview(self)
//        }
//        return self
//    }
//    
//    var lead: NSLayoutXAxisAnchor {
//        return leadingAnchor
//    }
//    
//    var trail: NSLayoutXAxisAnchor {
//        return trailingAnchor
//    }
//    
//    var top: NSLayoutYAxisAnchor {
//        return topAnchor
//    }
//    
//    var bot: NSLayoutYAxisAnchor {
//        return bottomAnchor
//    }
//    
//    var safeTop: NSLayoutYAxisAnchor {
//        return safeAreaLayoutGuide.topAnchor
//    }
//    
//    var safeBot: NSLayoutYAxisAnchor {
//        return safeAreaLayoutGuide.bottomAnchor
//    }
//    
//    var centerX: NSLayoutXAxisAnchor {
//        return centerXAnchor
//    }
//    
//    var centerY: NSLayoutYAxisAnchor {
//        return centerYAnchor
//    }
//
//    var width: NSLayoutDimension {
//        return widthAnchor
//    }
//
//    var height: NSLayoutDimension {
//        return heightAnchor
//    }
//    
//    @discardableResult
//    func width(_ value: CGFloat) -> Self {
//        widthAnchor.constraint(equalToConstant: value).isActive = true
//        return self
//    }
//    
//    @discardableResult
//    func height(_ value: CGFloat) -> Self {
//        heightAnchor.constraint(equalToConstant: value).isActive = true
//        return self
//    }
//    
//    @discardableResult
//    func lead(to: NSLayoutXAxisAnchor, gap: CGFloat = 0.0) -> Self {
//        lead.constraint(equalTo: to, constant: gap).isActive = true
//        return self
//    }
//    
//    @discardableResult
//    func trail(to: NSLayoutXAxisAnchor, gap: CGFloat = 0.0) -> Self {
//        trail.constraint(equalTo: to, constant: gap).isActive = true
//        return self
//    }
//    
//    @discardableResult
//    func top(to: NSLayoutYAxisAnchor, gap: CGFloat = 0.0) -> Self {
//        top.constraint(equalTo: to, constant: gap).isActive = true
//        return self
//    }
//    
//    @discardableResult
//    func centerX(to: NSLayoutXAxisAnchor, gap: CGFloat = 0.0) -> Self {
//        centerX.constraint(equalTo: to, constant: gap).isActive = true
//        return self
//    }
//    
//    @discardableResult
//    func centerY(to: NSLayoutYAxisAnchor, gap: CGFloat = 0.0) -> Self {
//        centerY.constraint(equalTo: to, constant: gap).isActive = true
//        return self
//    }
//    
//    @discardableResult
//    func bot(to: NSLayoutYAxisAnchor, gap: CGFloat = 0.0) -> Self {
//        bottomAnchor.constraint(equalTo: to, constant: gap).isActive = true
//        return self
//    }
//    
//    func pinEdges(to view: UIView, insets: UIEdgeInsets = .zero) {
//        translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
//            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right),
//            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
//            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom)
//        ])
//    }
//    
//    @discardableResult
//    func equalHeight(to: NSLayoutDimension, muliplier: CGFloat = 1) -> Self {
//        heightAnchor.constraint(equalTo: to, multiplier: muliplier).isActive = true
//        return self
//    }
//
//    @discardableResult
//    func equalWidth(to: NSLayoutDimension, muliplier: CGFloat = 1) -> Self {
//        widthAnchor.constraint(equalTo: to, multiplier: muliplier).isActive = true
//        return self
//    }
//    
//    private struct Keys {
//        static var height = "UIView_layout_height"
//        static var width = "UIView_layout_width"
//    }
//    
//    private var mHeight: NSLayoutConstraint? {
//        set {
//            if let newValue = newValue {
//                objc_setAssociatedObject(self, &Keys.height, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
//            }
//        }
//        get {
//            return objc_getAssociatedObject(self, &Keys.height) as? NSLayoutConstraint
//        }
//    }
//    
//    private var mWidth: NSLayoutConstraint? {
//        set {
//            if let newValue = newValue {
//                objc_setAssociatedObject(self, &Keys.width, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
//            }
//        }
//        get {
//            return objc_getAssociatedObject(self, &Keys.width) as? NSLayoutConstraint
//        }
//    }
//    
//    @discardableResult
//    func set(height: CGFloat) -> Self {
//        if let h = mHeight {
//            h.constant = height
//            h.isActive = true
//        } else {
//            mHeight = heightAnchor.constraint(equalToConstant: height)
//            mHeight?.isActive = true
//        }
//        return self
//    }
//    
//    @discardableResult
//    func set(width: CGFloat) -> Self {
//        if let w = mWidth {
//            w.constant = width
//            w.isActive = true
//        } else {
//            mWidth = widthAnchor.constraint(equalToConstant: width)
//            mWidth?.isActive = true
//        }
//        return self
//    }
//}
//
//extension UIView {
//    @nonobjc var h: CGFloat {
//        get {
//            return self.frame.height
//        }
//        set {
//            self.frame.size.height = newValue
//        }
//    }
//    
//    @nonobjc var w: CGFloat {
//        get {
//            return self.frame.width
//        }
//        set {
//            self.frame.size.width = newValue
//        }
//    }
//}
