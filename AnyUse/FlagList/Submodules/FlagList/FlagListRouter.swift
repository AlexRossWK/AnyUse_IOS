//
//  FlagListRouter.swift
//  AnyUse
//
//  Created by Алексей on 20..022022.
//

import Foundation

@MainActor
protocol FlagListRouting {
    func goToAddUpdate(currentFlag: Flag?) -> AddUpdateFlagView
}

@MainActor
class FlagListRouter: FlagListRouting {
    
    let addUpdateFlagAssembly: AddUpdateFlagAssembly
    
    init(addUpdateFlagAssembly: AddUpdateFlagAssembly) {
        self.addUpdateFlagAssembly = addUpdateFlagAssembly
    }
    
    func goToAddUpdate(currentFlag: Flag?) -> AddUpdateFlagView  {
        addUpdateFlagAssembly.createModule(currentFlag: currentFlag)
    }
}
