//
//  UIView+BoundingRect.swift
//  AnyUse
//
//  Created by Алексей on 22..022022.
//

import UIKit

extension UIView {
    /// Convenience method for determining the height of any UIView with a given width constraint.
    /// - Parameter width: Width constraint. Specify view's maximum width.
    /// - Returns: The height that this instance of UIView would have after layout event occurred.
    public func boundingHeight(width: CGFloat) -> CGFloat {
        systemLayoutSizeFitting(
            CGSize(
                width: width,
                height: 0
            ),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .defaultLow
        ).height
    }
}
