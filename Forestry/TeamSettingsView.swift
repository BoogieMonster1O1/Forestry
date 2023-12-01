//
//  TeamSettingsView.swift
//  Forestry
//
//  Created by Shrish Deshpande on 02/12/23.
//

import SwiftUI

struct TeamSettingsView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var showSheet = false
    @State var newTeamName: String
    @State var newTeamStrength: Int
    
    var body: some View {
        Form {
            Table(viewModel.teams) {
                TableColumn("Name", value: \.id)
                TableColumn("Strength") { i in
                    Text("\(i.count)")
                }
            }
            Button("Add team") {
                showSheet = true
            }
        }
        .sheet(isPresented: $showSheet) {
            VStack {
                Text("Add team")
                    .font(.title2)
                TextField("Team name", text: $newTeamName)
                TextField("Team strength", value: $newTeamStrength, formatter: NumberFormatter())
                Button("Cancel") {
                    showSheet = false
                }
                .keyboardShortcut(.escape)
                Button("Add") {
                    viewModel.teams.append(Team(name: newTeamName, count: newTeamStrength))
                    showSheet = false
                }
            }
            .padding(4)
        }
    }
}
