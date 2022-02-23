//
//  RNHorizontalToSuperview.swift
//  Currencies
//
//  Created by Alexey Rossoshansky on 17.06.2020.
//

import UIKit

public func RNHorizontalToSuperview(distance: CGFloat = 0) -> UIRelation {
    RelationBuilder.combine {
        RNLeftToSuperview(distance: distance)
        RNRightToSuperview(distance: distance)
    }
}
