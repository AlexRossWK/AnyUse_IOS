//
//  UINib+InitByType.swift
//  AnyUse
//
//  Created by Алексей on 22..022022.
//

import UIKit.UINib

public extension UINib {

    convenience init<T>(_ nibType: T.Type) where T: AnyObject {
        self.init(nibName: "\(nibType.self)", bundle: Bundle(for: nibType))
    }
}
