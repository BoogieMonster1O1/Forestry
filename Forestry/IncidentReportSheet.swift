//
//  IncidentReportSheet.swift
//  Forestry
//
//  Created by Shrish Deshpande on 02/12/23.
//

import SwiftUI

struct IncidentReportSheet: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @Binding var showIncidentReportSheet: Bool
    
    @State var description = ""
    @State var severity = 0
    let severityLevels = ["Very Low", "Low", "Moderate", "High", "Very High"]
    @State private var selectedDate = Date()
    private var dateTimeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        VStack {
            Text("Report an incident")
                .font(.title)
            Form {
                TextField("Description", text: $description)
                Picker("Severity", selection: $severity) {
                    ForEach(0 ..< 5) {
                        Text(self.severityLevels[$0])
                            .tag($0)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                DatePicker("Select Date and Time", selection: $selectedDate, in: ...Date(), displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(GraphicalDatePickerStyle())
            }
            HStack {
                Button("Cancel") {
                    showIncidentReportSheet = false
                }
                .keyboardShortcut(.escape)
                Button("Report") {
                    viewModel.incidents.append(Incident(description: description, severity: severity, date: selectedDate))
                    showIncidentReportSheet = false
                }
            }
        }
        .padding(10)
    }
}
