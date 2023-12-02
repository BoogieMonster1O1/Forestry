//
//  SetupSettingsView.swift
//  Forestry
//
//  Created by Shrish Deshpande on 02/12/23.
//

import SwiftUI
import OpenAI

struct SetupSettingsView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var selectedTree: String?
    @State var newTreeSheet: Bool = false
    @State var newTreeName: String = ""
    @State var suggestTreeSheet: Bool = false
    @State var suggestTreeAiSheet: Bool = false
    
    var body: some View {
        VStack {
            Form {
                TextField("Tree planting goal: ", value: $viewModel.goal, formatter: NumberFormatter())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            VStack {
                Text("Trees to be planted")
                List(selection: $selectedTree) {
                    if (viewModel.trees.isEmpty) {
                        Text("No trees added yet!")
                    } else {
                        ForEach(viewModel.trees, id: \.self) { tree in
                            Text(tree)
                                .tag(tree)
                        }
                    }
                }
            }
            .padding(.vertical, 4)
            
            HStack {
                Button("Add new tree") {
                    newTreeSheet = true
                }
                
                Button("Suggest tree type") {
                    suggestTreeSheet = true
                }
                
                Button("Suggest trees") {
                    suggestTreeAiSheet = true
                }
            }
        }
        .padding(10)
        .sheet(isPresented: $newTreeSheet) {
            VStack {
                Text("Add new tree")
                    .font(.title)
                
                TextField("Tree name", text: $newTreeName)
                
                HStack {
                    Button("Cancel") {
                        newTreeSheet = false
                    }
                    .keyboardShortcut(.escape)
                    Button("Add") {
                        viewModel.trees.append(newTreeName)
                        newTreeSheet = false
                        newTreeName = ""
                    }
                }
            }
            .padding(10)
        }
        .sheet(isPresented: $suggestTreeSheet) {
            TreeTypeSuggestion(suggestTreeSheet: $suggestTreeSheet)
        }
        .sheet(isPresented: $suggestTreeAiSheet) {
            TreeAiSuggestion(suggestTreeAiSheet: $suggestTreeAiSheet)
        }
    }
}

struct TreeAiSuggestion: View {
    @Binding var suggestTreeAiSheet: Bool
    @State var soilType: String = ""
    @State var climate: String = ""
    @State var location: String = ""
    @State var usedToCultivate: Bool = false
    @State var insurance: Bool = false
    @State var output: String = ""
    @State var progressBar: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("Tree AI Suggestion")) {
                TextField("Soil Type", text: $soilType)
                TextField("Climate", text: $climate)
                TextField("Location", text: $location)
                Toggle("Used to Cultivate in Last Month", isOn: $usedToCultivate)
                Toggle("Insurance against Natural Disasters", isOn: $insurance)
                
                if progressBar {
                    ProgressView()
                        .progressViewStyle(.circular)
                } else {
                    Text(output)
                        .monospaced()
                }
                
                HStack {
                    Button("Suggest") {
                        progressBar = true
                        Task {
                            do {
                                let result = try await openAi.chats(query: ChatQuery(model: .gpt4, messages: [
                                    Chat.init(role: .user, content: "Suggest trees for \(soilType) soil, \(climate), \(location), \(usedToCultivate ? "used to cultivate" : "not used to cultivate") in last month which land \(insurance ? "has" : "does not have") insurance against natural disasters.")
                                ]))
                                DispatchQueue.main.async {
                                    progressBar = false
                                    self.output = result.choices[0].message.content!
                                }
                            } catch {
                                print(error.localizedDescription)
                                print(error)
                                DispatchQueue.main.async {
                                    self.output = error.localizedDescription
                                    progressBar = false
                                }
                            }
                        }
                    }
                    
                    Button("Close") {
                        suggestTreeAiSheet = false
                    }
                }
                
            }
        }
        .padding()
    }
}

struct TreeTypeSuggestion: View {
    @Binding var suggestTreeSheet: Bool
    @State var prompt: String = ""
    let classifier = TreeStyleClassifier()
    @State var output: String = ""
    @State var concOutput: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter a description of your goals and environment. This is only a suggestion.", text: $prompt,  axis: .vertical)
                .lineLimit(4...6)
                .padding(.vertical, 5)
            if (output != "") {
                Text("Suggestion: \(output) trees")
                Text(concOutput)
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity,
                        alignment: .topLeading
                    )
            } else {
                Text("Too little text!")
            }
            HStack {
                Button("Done") {
                    suggestTreeSheet = false
                }
                .keyboardShortcut(.escape)
            }
            .onChange(of: prompt) { newThing in
                if prompt.hasMoreThan10Words() {
                    output = try! classifier.prediction(text: prompt).label
                    concOutput = getString(output)
                } else {
                    output = ""
                    concOutput = getString(output)
                }
            }
        }
        .padding(10)
    }
    
    func getString(_ output: String) -> String {
        if output == "evergreen" {
            return "Evergreen trees, like towering redwoods, aromatic cedars, vibrant hollies, versatile oaks, graceful firs, majestic pines, and iconic eucalyptus, contribute to biodiversity, provide habitats, and enhance landscapes globally with their enduring foliage."
        } else {
            return "Deciduous trees, shedding leaves seasonally, encompass diverse species, including the iconic maple, majestic oak, vibrant cherry, elegant birch, resilient beech, colorful sweetgum, and the graceful aspen. These trees play vital roles in ecosystems, showcasing seasonal beauty and ecological significance."
        }
    }
}

extension String {
    func hasMoreThan10Words() -> Bool {
        let words = self.components(separatedBy: .whitespacesAndNewlines)
        return words.count > 10
    }
}
