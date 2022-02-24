//
//  AppDelegate.swift
//  AnyUse
//
//  Created by Алексей on 20..022022.
//

import UIKit
import BackendTalk
import UIKitExtensions

class AppDelegate: NSObject, UIApplicationDelegate {
    var assemblies: Assemblies?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Перед началом работы ознакомиться с:
        // - TouchAreaExtending.swift
        createAssemblies()
        return true
    }
    
    private func createAssemblies() {
        //TODO: Create DI Container
        let flagService = FlagServiceImplementation(httpClient: HttpClient())
        let addUpdateFlagAssembly = AddUpdateFlagAssembly(service: flagService)
        let flagListRouter = FlagListRouter(addUpdateFlagAssembly: addUpdateFlagAssembly)
        let flagListAssembly = FlagListAssembly(service: flagService, router: flagListRouter)
        self.assemblies = Assemblies(
            flagListAssembly: flagListAssembly,
            addUpdateFlagAssembly: addUpdateFlagAssembly
        )
    }
}
