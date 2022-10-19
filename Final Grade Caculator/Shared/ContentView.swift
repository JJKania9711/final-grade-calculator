//
//  ContentView.swift
//  Shared
//
//  Created by James on 9/25/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var currentGradeTextField = ""
    @State private var finalWeightTextField = ""
    @State private var desiredGrade = 0.0
    @State private var requiredGrade = 0.0
        
    

    var body: some View {
        
        VStack {
            
            CustomText(text: "Final Grade Calculator")
                .padding()
                .background(.green)
            CustomTextField(placeholder: "Current Semester Grade", variable: $currentGradeTextField)
                .background(.green)
            CustomTextField(placeholder: "Final Weight", variable: $finalWeightTextField)
            Picker("Desired Semester Grade", selection: $desiredGrade) {
                Text("A").tag(90.0)
                Text("B").tag(80.0)
                Text("C").tag(70.0)
                Text("D").tag(60.0)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            Text("Required Grade On Final")
            CustomText(text: String(format: "%.1f", requiredGrade))
                .onChange(of: desiredGrade, perform: { newValue in
                    calculateGrade()
                })
                .background(requiredGrade > 100 ? Color.red : Color.green)
                .background(requiredGrade > 100 ? Color.red : Color.green.opacity(requiredGrade > 0 ? 1.0 : 0.0))
        }
    }
    
    func calculateGrade() {
        if let currentGrade = Double(currentGradeTextField) {
            if let finalWeight = Double(finalWeightTextField) {
                if finalWeight < 100 && finalWeight > 0 {
                    let finalPercentage = finalWeight / 100.0
                    requiredGrade = max(0.0,(desiredGrade - (currentGrade * (1.0 - finalPercentage))) / finalPercentage)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CustomTextField: View {
    let placeholder : String
    let variable : Binding<String>
    var body: some View {
        TextField(placeholder, text: variable)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .multilineTextAlignment(.center)
            .frame(width: 200, height: 30, alignment: .center)
            .font(.body)
            .padding()
            .background(.green)
    }
}

struct CustomText: View {
    let text : String
    var body : some View {
        Text(text)
        Text("Final Grade Calculator")
            .font(.title)
            .fontWeight(.bold)
            .background(.green)
    }
}

