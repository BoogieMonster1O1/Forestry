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
            if viewModel.goalExists {
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
            
            VStack {
                Text("Total inventory: \(viewModel.inventory.values.reduce(0, +))")
                let plantedTree = getMostPlantedTree()
                Text("Most planted: \(plantedTree.0) (\(plantedTree.1) trees)")
                let boughtTree = getMostBoughtTree()
                Text("Most bought: \(boughtTree.0) (\(boughtTree.1) trees)")
            }
            .padding(10)
        }
        .padding(10)
    }
    
    func getMostPlantedTree() -> (String, Int) {
        let invLog = viewModel.inventoryLog.filter { $0.action == .planted }
        
        var treeCounts: [String: Int] = [:]
        
        for log in invLog {
            let treeName = log.name
            treeCounts[treeName, default: 0] += log.count
        }
        
        if let mostPlantedTree = treeCounts.max(by: { $0.value < $1.value }) {
            return (mostPlantedTree.key, treeCounts[mostPlantedTree.key]!)
        } else {
            return ("Nothing yet!", 0)
        }
    }
    
    func getMostBoughtTree() -> (String, Int) {
        let invLog = viewModel.inventoryLog.filter { $0.action == .bought }
        
        var treeCounts: [String: Int] = [:]
        
        for log in invLog {
            let treeName = log.name
            treeCounts[treeName, default: 0] += log.count
        }
        
        if let mostBought = treeCounts.max(by: { $0.value < $1.value }) {
            return (mostBought.key, treeCounts[mostBought.key]!)
        } else {
            return ("Nothing yet!", 0)
        }
    }
}
