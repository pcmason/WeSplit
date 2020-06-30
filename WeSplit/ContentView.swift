//
//  ContentView.swift
//  WeSplit
//
//  Created by Paul Mason on 6/29/20.
//  Copyright © 2020 Paul Mason. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    //add three variables needed for check splitting app
    //checkAmount is a String because Swiftui must use Strings to store TextField values
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipIndex = 0
    //use selecte values for tip percentage
    let tipPercentages = [10, 15, 20, 25, 0]
    //add a computed property that just returns the totalAmount = orderAmount + TipValue
    var totalAmount: Double {
        //first get the tip percentage
        let tipSelection = Double(tipPercentages[tipIndex])
        //now use nil coalescing to ensure we recieve a valid orderAmount and convert it to a Double
        let orderAmount = Double(checkAmount) ?? 0
        //now calculate tipValue by dividing orderAmount by 100 and multiplying it by tipSelection
        let tipValue = (orderAmount / 100) * tipSelection
        //now calculate totAmount that is tipValue + orderAmount
        let totAmount = tipValue + orderAmount
        //return totAmount
        return totAmount
    }
    
    //add computed property totalPerPerson that will be a Double
    var totalPerPerson: Double {
        //first we get peopleCount which we have to add 2 to because it is 0 indexed
        //converts resulting value into a Double
        let peopleCount = Double(numberOfPeople) ?? 2
        //now get the the actual tip percentage from the array and convert it to a Double
        let tipSelection = Double(tipPercentages[tipIndex])
        //now add order amount double, which could be a valid string to convert to a double, or not vald so use nil coalescing to ensure no crashes
        let orderAmount = Double(checkAmount) ?? 0
        //now time for the math
        //first calculate tipValue dividing orderAmount by 100 and multiplying by tipSelection
        let tipValue = (orderAmount / 100) * tipSelection
        //calculate grandTotal of check by adding tipValue to orderAmount
        let grandTotal = tipValue + orderAmount
        //now amountPerPerson is grandTotal divided by peopleCount
        let amountPerPerson = grandTotal / peopleCount
        //now return amountPerPerson
        return amountPerPerson
    }
    
    var body: some View {
        //add a NavigationView so the picker works when you select it
        NavigationView {
            Form {
                Section {
                    //first string is placeholder second parameter is the two way binding var
                    TextField("Amount", text: $checkAmount)
                    //can add keyboardType that can take either numberPad or decimalPad to change the input text UI
                        .keyboardType(.decimalPad)
                    //now change this to TextField and ensure it has the right keyboard Type
                    TextField("How Many People are Splitting this Check", text: $numberOfPeople)
                    //use numberPad for keyboard
                        .keyboardType(.numberPad)
                }
                //create another section to decide the tipPercentage
                Section(header: Text("How Much Would You Like To Tip?")){
                    Picker("Tip Percentage", selection: $tipIndex){
                        ForEach(0 ..< tipPercentages.count){
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }//this will add segmented control style to the picker
                    .pickerStyle(SegmentedPickerStyle())
                }
                //add final section for totalPerPerson
                //add header here saying "Amount Per Person"
                Section(header: Text("Amount Per Person")) {
                    //use specifier to add decimal precision
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                //add another section for total Amount of the check
                Section(header: Text("Total Check Value")){
                    Text("$\(totalAmount, specifier: "%.2f")")
                }
            }
            //add a navigation bar title
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
