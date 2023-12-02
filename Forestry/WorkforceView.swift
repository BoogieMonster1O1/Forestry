//
//  WorkforceView.swift
//  Forestry
//
//  Created by Shrish Deshpande on 01/12/23.
//

import SwiftUI

struct WorkforceView: View {
    @EnvironmentObject var viewModel: ViewModel
    
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
