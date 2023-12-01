//
//  ViewModel.swift
//  Forestry
//
//  Created by Shrish Deshpande on 01/12/23.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @Published var goal: Float = 0
    @Published var current: Float = 0
    @Published var teams: [Team] = []
}

class Team: ObservableObject, Identifiable {
    @Published var id: String
    @Published var todayGoal: Int = 0
    @Published var count = 1
    
    init(name: String, count: Int) {
        self.id = name
    }
}
