//
//  SettingsView.swift
//  Forestry
//
//  Created by Shrish Deshpande on 01/12/23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        TabView {
            SetupSettingsView()
            .tabItem({
                Label("Setup", systemImage: "cup.and.saucer")
            })
            
//            TeamSettingsView()
//            .tabItem({
//                Label("Teams", systemImage: "person.3")
//            })
        }
    }
}
