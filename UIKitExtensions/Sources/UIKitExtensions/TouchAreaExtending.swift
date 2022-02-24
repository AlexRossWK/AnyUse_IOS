//
//  TouchAreaExtending.swift
//  AnyUse
//
//  Created by Алексей on 22..022022.
//

import UIKit.UIView

/// Минимальное кол-во *pt*, которое *Apple* рекомендует использовать по горизонтали и вертикали для нажатия на `UIControl`. [https://developer.apple.com/design/human-interface-guidelines/accessibility/overview/user-interaction/]
private let appleGuidelinesRecommendedTouchAreaSize: CGFloat = 44

// MARK: - TouchAreaExtending

/**
 Интерфейс, расширяющий область нажатия на `UIControl`.

 - Attention:
    Этот интерфейс применяется ко всем `UIView`-классам в приложении!!!

 # Хочу сделать кнопку с мелкой областью нажатия
    В этом случае необходимо проставить через *IB* или через `UIView().shouldUseRecommendedTouchAreaInsets` значение == `false`.
 */
protocol TouchAreaExtending: UIControl {

    /// Рекомендованная *Apple* область нажатия. По дефолту == **44pt** по горизонтали и вертикали. Если размер `UIControl` по высоте или ширине больше **44pt**, область нажатия в этой плоскости не будет меняться. По дефолту область нажатия == **44pt** по горизонтали и вертикали, если размер `UIControl` не превышает эти значения. Грубо говоря, кнопка, ширина которой == **20pt** будет нажиматься, как будто она шириной **44pt**.
    var recommendedTouchAreaInsets: UIEdgeInsets { get }
}

// MARK: - Default Implementation

extension TouchAreaExtending {

    var recommendedTouchAreaInsets: UIEdgeInsets {
        guard bounds.height < appleGuidelinesRecommendedTouchAreaSize || bounds.width < appleGuidelinesRecommendedTouchAreaSize else {
            return .zero
        }

        let verticalInset: CGFloat = bounds.height < appleGuidelinesRecommendedTouchAreaSize ? (appleGuidelinesRecommendedTouchAreaSize - bounds.height) / 2 : 0
        let horizontalInset: CGFloat = bounds.width < appleGuidelinesRecommendedTouchAreaSize ? (appleGuidelinesRecommendedTouchAreaSize - bounds.width) / 2 : 0
        return UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
    }
}

// MARK: - UIControl Extension

extension UIControl: TouchAreaExtending {}

extension UIControl {

    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard shouldUseRecommendedTouchAreaInsets else {
            return super.point(inside: point, with: event)
        }

        let extendedArea: CGRect = CGRect(
            x: -recommendedTouchAreaInsets.left,
            y: -recommendedTouchAreaInsets.top,
            width: bounds.width + recommendedTouchAreaInsets.left + recommendedTouchAreaInsets.right,
            height: bounds.height + recommendedTouchAreaInsets.top + recommendedTouchAreaInsets.bottom
        )
        return extendedArea.contains(point)
    }
}

// MAKR: - Private extension

private var key = "UIControl_shouldUseRecommendedTouchAreaInsets"

private extension UIControl {

    /// Флаг, который останавливает работа интерфейса `TouchAreaExtending`. Если вернуть тут `false`, область нажатия вьюхи никак не изменится - будет дефолтное поведение. По дефолту == `true`.
    @IBInspectable
    var shouldUseRecommendedTouchAreaInsets: Bool {
        get {
            return objc_getAssociatedObject(self, &key) as? Bool ?? true
        }
        set {
            objc_setAssociatedObject(self, &key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
