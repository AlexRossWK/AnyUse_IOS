//
//  Flag.swift
//  AnyUse
//
//  Created by Алексей on 19..022022.
//

import Foundation

struct Flag: Identifiable, Codable {
    let id: UUID?
    let name: String
    let description: String
    let value: Bool
}
