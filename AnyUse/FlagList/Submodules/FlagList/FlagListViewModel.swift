//
//  FlagListViewModel.swift
//  AnyUse
//
//  Created by Алексей on 19..022022.
//

import SwiftUI

class FlagListViewModel: ObservableObject {
    let service: FlagService
    @Published var flags = [Flag]()
    @Published var error: HttpError?

    init(service: FlagService) {
        self.service = service
    }
    
    @MainActor
    func fetchFlags() {
        Task {
            do {
                flags = try await service.fetchFlags()
                self.error = nil
            } catch {
                self.error = error as? HttpError
                print("❌ Error: \(error)")
            }
        }
    }
    
    @MainActor
    func deleteFlag(at offsets: IndexSet) {
        offsets.forEach { index in
            guard let flagID = flags[index].id else { return }
            Task {
                do {
                    try await service.deleteFlag(at: flagID)
                    self.error = nil
                } catch {
                    self.error = error as? HttpError
                    print("❌ Error: \(error)")
                }
            }
            flags.remove(atOffsets: offsets )
        }
    }
}
