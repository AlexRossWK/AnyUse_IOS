//
//  AlertContainerUpdatable.swift
//  Alerts
//
//  Created by Alexey Rossoshansky on 14.10.2020.
//

import UIKit

public protocol AlertContainerUpdatable {
    func updateContainer(_ view: UIView)
}

extension AlertManagerImplementation: AlertContainerUpdatable {
    public func updateContainer(_ view: UIView) {
        self.container = view
    }
}
