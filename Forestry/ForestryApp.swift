//
//  ForestryApp.swift
//  Forestry
//
//  Created by Shrish Deshpande on 01/12/23.
//

import SwiftUI

@main
struct ForestryApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
