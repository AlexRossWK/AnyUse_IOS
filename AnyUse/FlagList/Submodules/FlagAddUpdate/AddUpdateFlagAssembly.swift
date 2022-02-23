//
//  AddUpdateFlagAssembly.swift
//  AnyUse
//
//  Created by Алексей on 20..022022.
//

import SwiftUI

@MainActor
class AddUpdateFlagAssembly {
    
    let service: FlagService
    
    init(service: FlagService) {
        self.service = service
    }
    
    func createModule(currentFlag: Flag?) -> AddUpdateFlagView {
        if let flag = currentFlag {
            return AddUpdateFlagView(viewModel: AddUpdateFlagViewModel(service: service, currentFlag: flag))
        } else {
            return AddUpdateFlagView(viewModel: AddUpdateFlagViewModel(service: service))
        }
    }
}
