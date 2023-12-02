//
//  InventoryView.swift
//  Forestry
//
//  Created by Shrish Deshpande on 02/12/23.
//

import SwiftUI

struct InventoryView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @State var showAddInventorySheet = false
    @State var selectedTree = ""
    @State var selectedCount: Int = 1
    @State var selectedOption: InventoryAction = .bought
    @State var selectedDate: Date = Date.now
    
    let options: [InventoryAction] = [.bought, .spoiled, .planted]
    
    var body: some View {
        VStack {
            Text("Inventory")
                .font(.largeTitle)
            Text("Current Inventory")
            Table(of: String.self) {
                TableColumn("Name", value: \.self)
                TableColumn("Count") { thing in
                    Text("\(viewModel.inventory[thing] ?? 0)")
                }
            } rows: {
                ForEach(viewModel.trees, id: \.self) { tree in
                    let ct = viewModel.inventory[tree] ?? 0
                    if ct != 0 {
                        TableRow(tree)
                    }
                }
            }
            .frame(maxHeight: 250)
            
            Text("Inventory Log")
            Table(viewModel.inventoryLog) {
                TableColumn("Date", value: \.dateStr)
                TableColumn("Name", value: \.name)
                TableColumn("Action", value: \.action.rawValue)
                TableColumn("Count", value: \.countStr)
            }
            
            HStack {
                Button("New Action") {
                    showAddInventorySheet = true
                }
            }
        }
        .sheet(isPresented: $showAddInventorySheet, content: {
            VStack {
                Form {
                    Picker("Select ", selection: $selectedTree) {
                        ForEach(viewModel.trees, id: \.self) {
                            Text($0).tag($0)
                        }
                    }
                    .pickerStyle(.inline)
                    
                    Button("Add entry") {
                        NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
                    }
                    
                    Picker("Select Option", selection: $selectedOption) {
                        ForEach(options, id: \.self) {
                            Text($0.rawValue)
                                .tag($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    TextField("Count", value: $selectedCount, formatter: NumberFormatter())
                    
                    DatePicker("Select Date and Time", selection: $selectedDate, in: ...Date(), displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(GraphicalDatePickerStyle())
                }
                
                HStack {
                    Button("Cancel") {
                        showAddInventorySheet = false
                    }
                    Button("Add") {
                        viewModel.inventoryLog.append(InventoryLog(name: selectedTree, action: selectedOption, count: selectedCount, date: selectedDate))
                        let sign = selectedOption == .bought ? 1 : -1
                        viewModel.inventory[selectedTree] = (viewModel.inventory[selectedTree] ?? 0) + selectedCount * sign
                        showAddInventorySheet = false
                    }
                }
            }
            .padding(10)
        })
        .padding(10)
    }
}

extension String: Identifiable {
    public var id: String { self }
}
