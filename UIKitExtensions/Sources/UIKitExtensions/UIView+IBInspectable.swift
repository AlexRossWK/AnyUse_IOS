//
//  UIView+IBInspectable.swift
//  AnyUse
//
//  Created by Алексей on 22..022022.
//

import UIKit

public extension UIView {

    /// Включена ли растеризация.
    @IBInspectable
    var isRasterized: Bool {
        get {
            return layer.shouldRasterize
        }
        set {
            layer.shouldRasterize = newValue
            layer.rasterizationScale = newValue ? UIScreen.main.scale : 1.0
        }
    }
}

public extension UIView {

    /// A Boolean indicating whether sublayers are clipped to the layer’s bounds. Animatable.
    @IBInspectable
    var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
}

public extension UIView {

    /// The radius to use when drawing rounded corners for the layer’s background. Animatable.
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}

public extension UIView {

    /// The width of the layer’s border. Animatable.
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    /// The color of the layer’s border. Animatable.
    @IBInspectable
    var borderColor: UIColor? {
        get {
            guard let cgColor = layer.borderColor else {
                return nil
            }

            return UIColor(cgColor: cgColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

public extension UIView {

    @IBInspectable
    /// `true`, если `tintAdjustmentMode` == `.normal`. При `tintAdjustmentMode` == `.automatic` || `.dimmed` вернется `false`. Нужно для того, чтобы при отображении алертов и модальных контроллеров не выцветались вьюхи, у которых используется `tintColor`.
    var isTintAdjustmentModeNormal: Bool {
        get {
            tintAdjustmentMode == .normal
        }
        set {
            tintAdjustmentMode = .normal
        }
    }
}
