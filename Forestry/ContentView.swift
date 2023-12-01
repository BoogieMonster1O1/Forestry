//
//  ContentView.swift
//  Forestry
//
//  Created by Shrish Deshpande on 01/12/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var showIncidentReportSheet = false
    
    var body: some View {
        NavigationView {
            List {
                SidebarEntry(image: Image(systemName: "slowmo"), label: "Dashboard", small: "") {
                    DashboardView()
                }
                SidebarEntry(image: Image(systemName: "box.truck"), label: "Inventory", small: "Manage seed and sapling inventory") {
                    Text("inventory lol")
                }
                SidebarEntry(image: Image(systemName: "person.3.sequence"), label: "Workforce", small: "Manage workforce and volunteers") {
                    WorkforceView()
                }
                SidebarEntry(image: Image(systemName: "exclamationmark.triangle.fill"), label: "Incident Log", small: "See past incidents") {
                    IncidentLogView()
                }
            }
            .listStyle(.sidebar)
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
                    }) {
                        Image(systemName: "sidebar.leading")
                    }
                }
                
                ToolbarItem {
                    Button(action: {
                        self.showIncidentReportSheet = true
                    }) {
                        Image(systemName: "exclamationmark.triangle")
                    }
                }
            }
            Text("Select an item")
        }
        .sheet(isPresented: $showIncidentReportSheet, content: incidentReportSheet)
    }
    
    @ViewBuilder
    func incidentReportSheet() -> some View {
        VStack {
            Text("Report an incident")
                .font(.title)
            HStack {
                Button("Cancel") {
                    showIncidentReportSheet = false
                }
                .keyboardShortcut(.escape)
                Button("Report") {
                    // TODO: add
                    showIncidentReportSheet = false
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
