//
//  RNTopAndBottomToSuperview.swift
//  UIRelationship
//
//  Created by Alexey Rossoshansky on 01.12.2021.
//

import UIKit

public func RNTopAndBottomToSuperview(distance: CGFloat = 0) -> UIRelation {
    RelationBuilder.combine {
        RNTopToSuperview(distance: distance)
        RNBottomToSuperview(distance: distance)
    }
}
