//
//  ForestryApp.swift
//  Forestry
//
//  Created by Shrish Deshpande on 01/12/23.
//

import SwiftUI

@main
struct ForestryApp: App {
    var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }.commands {
            SidebarCommands()
        }
        Settings {
            SettingsView()
                .environmentObject(viewModel)
                .frame(width: 800, height: 400)
        }
    }
}
