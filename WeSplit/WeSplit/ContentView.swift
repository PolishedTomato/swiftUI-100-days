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
    
    let tipPrecents = [15, 25, 30, 50, 0]
    
    var totalPerPerson:Double{
        let tip = checkAmount * Double(tipPrecent)/100
        let totalAmount = checkAmount + tip
        
        return totalAmount / Double(numOfPeople)
    }
    
    var body: some View {
        VStack {
            NavigationView{
                Form{
                    Section("Enter your check amount"){
                        TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocus)
                    
                        Picker("Select number of people", selection: $numOfPeople){
                            ForEach(1..<99){
                                p in Text("\(p) people")
                                    .tag(p)
                            }
                        }
                    }
                    
                    Section{
                        Picker("Select tip precentage", selection: $tipPrecent){
                            ForEach(tipPrecents, id: \.self){
                                tip in Text("\(tip)")
                            }
                        }
                        .pickerStyle(.segmented)
                    } header: {
                        Text("Enter your tip amount")
                    }
                    
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
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
