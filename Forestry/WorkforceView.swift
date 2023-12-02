//
//  WorkforceView.swift
//  Forestry
//
//  Created by Shrish Deshpande on 01/12/23.
//

import SwiftUI

struct WorkforceView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var showSheet: Bool = false
    @State var newTeamName: String = ""
    @State var newTeamStrength: Int = 0
    
    var body: some View {
        VStack {
            Text("Workforce")
                .font(.largeTitle)
            
            Table(viewModel.teams) {
                TableColumn("Name", value: \.id)
                TableColumn("Strength") { i in
                    Text("\(i.count)")
                }
            }
            .padding(6)
            
            Text("Today: \(Date.getCurrentDate())")
            
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
                    newTeamName = ""
                    newTeamStrength = 0
                }
                .keyboardShortcut(.return)
            }
            .padding(10)
        }
        .padding(10)
    }
}

extension Date {
    static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: Date())
    }
}
