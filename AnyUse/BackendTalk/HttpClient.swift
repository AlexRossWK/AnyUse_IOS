//
//  HttpClient.swift
//  AnyUse
//
//  Created by Алексей on 19..022022.
//

import Foundation

class HttpClient {
    func get<T: Codable>(url: URL) async throws -> [T] {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
        
        guard let object = try? JSONDecoder().decode([T].self, from: data) else {
            throw HttpError.decodingError
        }
        
        return object
    }
    
    func post<T: Codable>(url: URL, object: T) async throws {
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.post.rawValue
        request.addValue(MimeType.json.rawValue, forHTTPHeaderField: HttpHeaders.contentType.rawValue)
        request.httpBody = try? JSONEncoder().encode(object)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
    }
    
    func put<T: Codable>(url: URL, object: T) async throws {
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.put.rawValue
        request.addValue(MimeType.json.rawValue, forHTTPHeaderField: HttpHeaders.contentType.rawValue)
        request.httpBody = try? JSONEncoder().encode(object)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
    }
    
    func delete(url: URL) async throws {
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.delete.rawValue
        let (_, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
    }
}
