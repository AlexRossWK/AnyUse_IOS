//
//  AddUpdateFlagViewModel.swift
//  AnyUse
//
//  Created by Алексей on 20..022022.
//

import SwiftUI
import BackendTalk

@MainActor
class AddUpdateFlagViewModel: ObservableObject {
    let service: FlagService

    @Published var flagName: String = ""
    @Published var flagDescription: String = ""
    @Published var flagValue: Bool = false
    
    @Published var error: HttpError?
    
    private var flagID: UUID?

    var isUpdating: Bool {
        flagID != nil
    }
    
    var buttonTitle: String {
        isUpdating ? "Update" : "Add"
    }
    
    init(service: FlagService) {
        self.service = service
    }
    
    init(service: FlagService, currentFlag: Flag) {
        self.service = service
        flagID = currentFlag.id
        flagName = currentFlag.name
        flagDescription = currentFlag.description
        flagValue = currentFlag.value
    }
    
    @MainActor
    func addUpdateFlag(isSucceed: @escaping (Bool) -> Void) {
        Task {
            do {
                if isUpdating {
                    try await service.updateFlag(flag: Flag(id: flagID, name: flagName, description: flagDescription, value: flagValue))
                } else {
                    try await service.addFlag(flag: Flag(id: nil, name: flagName, description: flagDescription, value: flagValue))
                }
                self.error = nil
                isSucceed(true)
            } catch {
                self.error = error as? HttpError
                print("❌ Error: \(error)")
                isSucceed(false)

            }
        }
    }
}
