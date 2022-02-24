//
//  RNSidesToSubperview.swift
//  UIRelationship
//
//  Created by Alexey Rossoshansky on 16.09.2020.
//

import UIKit

public func RNSidesToSuperview(distance: CGFloat = 0) -> UIRelation {
    RelationBuilder.combine {
        RNLeftToSuperview(distance: distance)
        RNRightToSuperview(distance: distance)
    }
}
