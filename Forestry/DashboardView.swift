//
//  DashboardView.swift
//  Forestry
//
//  Created by Shrish Deshpande on 01/12/23.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Text("Dashboard")
                .font(.largeTitle)
            if (viewModel.goal <= 0) {
                Text("Set a goal in settings to get started")
                    .font(.title2)
            } else {
                Text("Your goal is: \(Int(viewModel.goal))")
                    .font(.title2)
                ProgressView(value: viewModel.current, total: viewModel.goal)
                    .frame(maxWidth: .infinity)
                if ((Int(viewModel.goal) -  Int(viewModel.current)) <= 0) {
                    Text("You've reached your goal! Congratulations!")
                } else {
                    Text("\(Int(viewModel.goal) -  Int(viewModel.current)) trees to goal")
                }
            }
        }
        .padding(10)
    }
}
