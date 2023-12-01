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
                // TODO: fixme
            }
        }
    }
}
