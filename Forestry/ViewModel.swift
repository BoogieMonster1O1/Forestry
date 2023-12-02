//
//  ViewModel.swift
//  Forestry
//
//  Created by Shrish Deshpande on 01/12/23.
//

import Foundation
import OpenAI
import SwiftUI

class ViewModel: ObservableObject {
    @Published var goalExists: Bool = false
    @Published var goal: Float = 1000
    @Published var current: Float = 305
    @Published var teams: [Team] = [
        .init(name: "Team Vyoma", count: 20),
        .init(name: "Team Jatayu", count: 15),
        .init(name: "ALAAP", count: 15),
        .init(name: "CarvK", count: 10),
        .init(name: "Ashwa Racing", count: 20),
    ]
    @Published var trees: [String] = ["Mahogany", "Teak", "Shisham", "Sandalwood", "Oak", "Deodar"]
    @Published var inventory: [String : Int] = [
        "Mahogany": 100,
        "Sandalwood": 150,
        "Teak": 60
    ]
    @Published var incidents: [Incident] = []
    @Published var inventoryLog: [InventoryLog] = [
        .init(name: "Mahogany", action: .bought, count: 100, date: Date.now),
        .init(name: "Sandalwood", action: .bought, count: 200, date: Date.now),
        .init(name: "Sandalwood", action: .planted, count: 50, date: Date.now),
        .init(name: "Teak", action: .bought, count: 60, date: Date.now)
    ]
    @Published var suppliers: [Supplier] = [
        .init(name: "Nuziveedu Seeds Ltd.", email: "contact@nuziveedu.in", product: "Saplings"),
        .init(name: "Bharat Biotech", email: "contact@bharatbiotech.in", product: "Fertilizer"),
        .init(name: "Tata Chemicals", email: "contact@tatachemicals.in", product: "Fertilizer"),
        .init(name: "Green my life", email: "info@greenmylife.in", product: "Saplings"),
        .init(name: "Indian Forest Service", email: "ifc@nic.in", product: "Saplings"),
        .init(name: "Karnataka Forest Service", email: "kfs@karnataka.gov.in", product: "Saplings")
    ]
}

class InventoryLog: ObservableObject, Identifiable {
    @Published var date: Date
    @Published var count: Int
    @Published var action: InventoryAction
    @Published var name: String
    
    init(name: String, action: InventoryAction, count: Int, date: Date) {
        self.name = name
        self.action = action
        self.count = count
        self.date = date
    }
    
    var dateStr: String {
        dateTimeFormatter.string(from: date)
    }
    
    var countStr: String {
        String(count)
    }
}

class Supplier: ObservableObject, Identifiable, Hashable {
    @Published var name: String
    @Published var email: String
    @Published var product: String
    
    init(name: String, email: String, product: String) {
        self.name = name
        self.email = email
        self.product = product
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func == (lhs: Supplier, rhs: Supplier) -> Bool {
        return lhs.name == rhs.name
    }
}

let token1 = "sk-MuyKFFQnAHZ9eo9BeozET3"
let token2 = "BlbkFJZNZlotMqoQwMflOWfzML"
let token3 = "sk-v19COzARHEZzQmq1ff3MT"
let token4 = "3BlbkFJjK7VK1DJXoqhdcfDIKui"
let apiKey = token3 + token4
let openAi = OpenAI.init(apiToken: apiKey)


enum InventoryAction: String {
    case bought = "Bought"
    case spoiled = "Spoiled"
    case planted = "Planted"
}

class Team: ObservableObject, Identifiable {
    @Published var id: String
    @Published var todayGoal: Int = 0
    @Published var count: Int
    
    init(name: String, count: Int) {
        self.id = name
        self.count = count
    }
}

private var dateTimeFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .short
    return formatter
}

class Incident: ObservableObject, Identifiable {
    private static let severityLevels = ["Very Low", "Low", "Moderate", "High", "Very High"]
    @Published var id: UUID = UUID()
    @Published var description: String
    @Published var severity: Int
    @Published var date: Date
    
    var severityString: String {
        Incident.severityLevels[severity]
    }
    
    var dateStr: String {
        dateTimeFormatter.string(from: date)
    }
    
    init(description: String, severity: Int, date: Date) {
        self.description = description
        self.severity = severity
        self.date = date
    }
}
