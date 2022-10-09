//
//  ContentView.swift
//  WeSplit
//
//  Created by Deye Lei on 10/7/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double = 10.0
    @State private var tipPrecent: Int = 0
    @State private var numOfPeople: Int = 1
    @FocusState private var amountIsFocus: Bool
    
    //store currency code in a variable
    let currencyCode: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    
    let tipPrecents = [15, 25, 30, 50, 0]
    
    var totalPerPerson:Double{
        let tip = checkAmount * Double(tipPrecent)/100
        let totalAmount = checkAmount + tip
        
        return totalAmount / Double(numOfPeople)
    }
    
    var totalAmount: Double{
        return checkAmount + checkAmount * Double(tipPrecent) / 100
    }
    
    var body: some View {
        VStack {
            NavigationView{
                Form{
                    Section("Enter your check amount"){
                        TextField("Amount", value: $checkAmount, format: currencyCode)
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocus)
                    
                        Picker("Select number of people", selection: $numOfPeople){
                            ForEach(1..<99){
                                p in Text("\(p) people")
                                    .tag(p)
                            }
                        }
                    }
                    /*
                    Section{
                        Picker("Select tip precentage", selection: $tipPrecent){
                            ForEach(tipPrecents, id: \.self){
                                tip in Text("\(tip)")
                            }
                        }
                        .pickerStyle(.segmented)
                    } header: {
                        Text("Enter your tip amount")
                    }*/
                    //another picker where picker can select from 0 to 100
                    Section{
                        Picker("Select tip precentage", selection: $tipPrecent){
                            ForEach(0..<101){
                                tip in Text("\(tip) %" )
                            }
                        }
                    } header: {
                        Text("Enter your tip amount")
                    }
                    
                    Section{
                        Text((totalAmount), format: currencyCode)
                    } header:{
                        Text("Total amount")
                    }
                    
                    Section{
                        Text(totalPerPerson, format: currencyCode)
                    } header: {
                        Text("Amount per person")
                    }
                    
                    }
                .navigationTitle("WeSplit")
                .navigationBarTitleDisplayMode(.large)
                .toolbar{
                    ToolbarItemGroup(placement: .keyboard){
                        Spacer()
                        Button{
                            amountIsFocus = false
                        } label:{
                            Text("Done")
                        }
                    }
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
