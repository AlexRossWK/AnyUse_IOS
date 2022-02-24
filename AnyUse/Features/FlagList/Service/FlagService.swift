//
//  FlagService.swift
//  AnyUse
//
//  Created by Алексей on 19..022022.
//

import Foundation
import BackendTalk

protocol FlagService {
    func fetchFlags() async throws -> [Flag]
    func addFlag(flag: Flag) async throws
    func updateFlag(flag: Flag) async throws
    func deleteFlag(at id: UUID) async throws
}

class FlagServiceImplementation: FlagService {
    let httpClient: HttpClient
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    func fetchFlags() async throws -> [Flag] {
        let urlString = Constants.baseUrl + Constants.Endpoints.flags
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        return try await httpClient.get(url: url)
    }
    
    func addFlag(flag: Flag) async throws {
        let urlString = Constants.baseUrl + Constants.Endpoints.flags
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        return try await httpClient.post(url: url, object: flag)
    }
    
    func updateFlag(flag: Flag) async throws {
        let urlString = Constants.baseUrl + Constants.Endpoints.flags
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        return try await httpClient.put(url: url, object: flag)
    }
    
    func deleteFlag(at id: UUID) async throws {
        let urlString = Constants.baseUrl + Constants.Endpoints.flags + "/\(id.uuidString)"
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        return try await httpClient.delete(url: url)
    }
}
