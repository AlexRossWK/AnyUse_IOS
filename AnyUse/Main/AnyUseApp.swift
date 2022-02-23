//
//  AnyUseApp.swift
//  AnyUse
//
//  Created by Алексей on 19..022022.
//

import SwiftUI

@main
struct AnyUseApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            appDelegate.assemblies?.flagListAssembly.createModule()
        }
    }
}
