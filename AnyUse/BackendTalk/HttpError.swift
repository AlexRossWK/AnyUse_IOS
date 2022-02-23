//
//  HttpError.swift
//  AnyUse
//
//  Created by Алексей on 19..022022.
//

import Foundation

enum HttpError: String, Error, Identifiable {
    var id: String { localizedDescription }
    case badURL = "Can't create URL object"
    case badResponse = "Bad response. Status code is not 2**"
    case decodingError = "Error in process of decoding"
    case invalidURL = "Invalid url"
    
    var localizedDescription: String { self.rawValue }
}
