//
//  ContentView.swift
//  Converter
//
//  Created by Andrii Boichuk on 10/11/2026.
//

import SwiftUI

enum ConverterUnit: String {
    case celsius
    case fahrenheit
    case kelvin
}

struct ContentView: View {
    @State var inputValue: Double = 0
    @State var inputType: ConverterUnit = .celsius
    @State var outputType: ConverterUnit = .fahrenheit
    @FocusState private var isFocused: Bool
    
    private var baseInputValue: Double {
        switch inputType {
        case .celsius:
            return inputValue
        case .fahrenheit:
            return inputValue - 32 / (9/5)
        case .kelvin:
            return inputValue - 273.15
        }
    }
    
    private var outputValue: Double  {
        switch outputType {
        case .celsius:
            return baseInputValue
        case .fahrenheit:
            return baseInputValue * 9/5 + 32
        case .kelvin:
            return baseInputValue + 273.15
        }
    }
    private let inputTypes: [ConverterUnit] = [.celsius, .fahrenheit, .kelvin]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Please choose value to convert") {
                    TextField("Input Temperature", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    Picker("Input Temperature", selection: $inputType) {
                        ForEach(inputTypes, id: \.self) {
                            Text($0.rawValue)
                        }
                    }.pickerStyle(.segmented)
                }
                Section("Temperature in \(outputType.rawValue)") {
                    Picker("Output Temperature", selection: $outputType) {
                        ForEach(inputTypes, id: \.self) {
                            Text($0.rawValue)
                        }
                    }.pickerStyle(.segmented)
                    Text(outputValue, format: .number)
                }
            }
            .navigationTitle("Temperature Converter")
            .toolbar {
                if isFocused {
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
