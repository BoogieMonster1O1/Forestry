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
            Form {
                TextField("Tree planting goal: ", value: $viewModel.goal, formatter: NumberFormatter())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .tabItem({
                Label("Setup", systemImage: "cup.and.saucer")
            })
            
            TeamSettingsView()
            .tabItem({
                Label("Teams", systemImage: "person.3")
            })
        }
    }
}
