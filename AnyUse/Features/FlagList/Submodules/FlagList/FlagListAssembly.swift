//
//  FlagListAssembly.swift
//  AnyUse
//
//  Created by Алексей on 20..022022.
//

import SwiftUI

@MainActor
class FlagListAssembly {
    let service: FlagService
    let router: FlagListRouter
    
    init(
        service: FlagService,
        router: FlagListRouter
    ) {
        self.service = service
        self.router = router
    }
    
    func createModule() -> FlagListView {
        FlagListView(
            viewModel: FlagListViewModel(service: self.service),
            router: router
        )
    }
}
