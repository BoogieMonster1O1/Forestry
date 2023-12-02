//
//  IncidentLogView.swift
//  Forestry
//
//  Created by Shrish Deshpande on 02/12/23.
//

import SwiftUI

struct IncidentLogView: View {
    @EnvironmentObject var viewModel: ViewModel
    let severityLevels = ["Very Low", "Low", "Moderate", "High", "Very High"]
    
    var body: some View {
        VStack {
            Text("Incidents")
                .font(.largeTitle)
            
            Table(viewModel.incidents) {
                TableColumn("Description", value: \.description)
                TableColumn("Severity", value: \.severityString)
                TableColumn("Date", value: \.dateStr)
            }
            .frame(maxHeight: 200)
        }
        .padding(10)
    }
}
