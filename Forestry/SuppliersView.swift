//
//  SuppliersView.swift
//  Forestry
//
//  Created by Shrish Deshpande on 02/12/23.
//

import SwiftUI

struct SuppliersView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var showingSheet = false
    @State private var selectedSupplier: Supplier?
    @State var searchTerm: String = ""

    var body: some View {
        VStack {
            Text("Suppliers")
                .font(.largeTitle)
            TextField("Search", text: $searchTerm)
                .padding(.top, 6)
                .frame(maxWidth: .infinity)
            List(selection: $selectedSupplier) {
                ForEach(viewModel.suppliers, id: \.email) { supplier in
                    if (searchTerm == "" || supplier.name.lowercased().contains(searchTerm.lowercased()) || supplier.email.lowercased().contains(searchTerm.lowercased()) ||
                        supplier.product.lowercased().contains(searchTerm.lowercased())) {
                        VStack(alignment: .leading) {
                            Text(supplier.name)
                                .font(.headline)
                            Text("Email: \(supplier.email)")
                                .foregroundColor(.gray)
                            Text("Product: \(supplier.product)")
                                .foregroundColor(.gray)
                        }
                        .tag(supplier)
                    }
                }
            }
            .sheet(isPresented: $showingSheet) {
                SupplierSheetView(supplier: selectedSupplier!, showingSheet: $showingSheet)
            }
            
            HStack {
                Button("Contact") {
                    NSWorkspace.shared.open(URL(string: "mailto:\(selectedSupplier!.email)")!)
                }
                .disabled(selectedSupplier == nil)
                
                Button("Buy now") {
                    showingSheet = true
                }
                .disabled(selectedSupplier == nil)
            }
        }
        .padding(10)
    }
}

struct SupplierSheetView: View {
    var supplier: Supplier
    @Binding var showingSheet: Bool
    
    @State var qty: Int = 1
    
    var body: some View {
        VStack {
            Form {
                TextField("Enter quantity", value: $qty, formatter: NumberFormatter())
                                .padding()
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                
                HStack {
                    Button("Cancel") {
                        showingSheet = false
                    }
                    
                    Button("Buy") {
                        // Add logic to buy
                        showingSheet = false
                    }
                }
            }
        }
        .padding(10)
    }
}
