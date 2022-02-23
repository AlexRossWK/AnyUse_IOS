//
//  FlagListRouteType.swift
//  AnyUse
//
//  Created by Алексей on 20..022022.
//

import Foundation

enum FlagListRouteType: Identifiable {
    case add
    case update(Flag)
    
    var id: String {
        switch self {
        case .add: return "add"
        case .update: return "update"
        }
    }
}
