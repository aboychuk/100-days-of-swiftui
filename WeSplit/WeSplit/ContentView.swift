//
//  ContentView.swift
//  WeSplit
//
//  Created by Andrii Boichuk on 09/11/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double = 0.0
    @State private var numberOfPeople: Int = 2
    @State private var tipPercentage: Int = 20
    
    @FocusState private var amountIsFocused: Bool
    
    private var tipPercentages = [5, 10, 15, 20, 25, 0]
    
    private var peopleCount: Double {
        return Double(numberOfPeople + 2)
    }
    private var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    private var totalPerPerson: Double {
        return grandTotal / peopleCount
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Check amount",
                              value: $checkAmount,
                              format: .currency(code: Locale.current.currency?.identifier ?? "PLN"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
//                        ForEach(0..<101) {
//                            Text($0, format: .percent)
//                        }
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.navigationLink)
                }
                Section("Total amount for check") {
                    
                    Text(grandTotal,
                         format: .currency(code: Locale.current.currency?.identifier ?? "PLN"))
                    .foregroundStyle(tipPercentage == 0 ? .red : .black)
                }
                Section("Amount per person") {
                    Text(totalPerPerson,
                         format: .currency(code: Locale.current.currency?.identifier ?? "PLN"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
