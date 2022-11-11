//
//  ContentView.swift
//  WeSplit
//
//  Created by Eric Kuo on 2022/11/9.
//

import SwiftUI

//ContentView conforms to the View protocol.
//View comes from SwiftUI, and is the basic protocol that must be adopted by anything you want to draw on the screen
//some View, means it will return something that conforms to the View protocol, which is our layout.

//@State allows us to work around the limitation of structs: we know we can’t change their properties because structs are fixed, but @State allows that value to be stored separately by SwiftUI in a place that can be modified.

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    let tipPercentages = [10, 15, 20, 25, 0]
    
    
    var grandTotalOfCheck: Double {
        // calculate the toal per person
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = grandTotalOfCheck / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 21) {
                            Text("\($0) people")
                        }
                    }
                    //.pickerStyle(.automatic)
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(grandTotalOfCheck, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("total amount for check")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
        
    }
    
    /*
    @State private var tapCount = 0
    @State private var name = ""
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = "Harry"
    
    var body: some View {
        VStack {
            Form {
                Button("Tap Count: \(tapCount)"){
                    self.tapCount += 1
                }
                TextField("Enter your name", text: $name)
                Text("Your name is \(name)")
                Picker("Select your student", selection: $selectedStudent) {
                    ForEach(students, id: \.self) {
                        Text($0)
                    }
                }
            } //$name, two-way binding: we bind the text field so that it shows the value of our property, but we also bind it so that any changes to the text field also update the property.
            
        }
        */
        
        
        
        /*
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Form {
                Section{
                    Text("Whats up")
                }
                Text("Hello, world!")
                Text("Hello, world!")
                Text("Hello, world!")
            }
        }
        .padding(1.0)
         
    }
         */
}


//padding() method is a modifier, which are regular methods with one small difference: they always return a new view that contains both your original data, plus the extra modification you asked for.

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//This piece of code won’t actually form part of your final app that goes to the App Store, but is instead specifically for Xcode to use so it can show a preview of your UI design alongside your code.
//The Xcode features canvas, a preview on the right. You can customize the preview code if you want, and they will only affect the way the canvas shows your layouts – it won’t change the actual app that gets run.

/*
 struct ContentView: View {
     var body: some View {
             Form {
                 Section{
                     Text("Whats up")
                 }
                 Text("Hello, world!")
                 Text("Hello, world!")
                 Text("Hello, world!")
             }
     }
 }
 */
