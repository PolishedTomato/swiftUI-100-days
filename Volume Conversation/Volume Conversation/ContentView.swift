//
//  ContentView.swift
//  Volume Conversation
//
//  Created by Deye Lei on 10/9/22.
//

import SwiftUI

struct ContentView: View {
    @State var volumeOfUnit: Double = 0.0
    @State var selected_Unit = "liters"
    let volumes = ["liters", "milliliters", "cups", "pints", "gallons"]
    
    var numberFormatter = NumberFormatter()
    
    mutating func format_number(input: Double) -> String?{
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: input))
    }
    
    var inLiters: Double{
        if selected_Unit == "liters"
        {
            return volumeOfUnit
        }
        else if selected_Unit == "milliliters"{
            return volumeOfUnit * 1000
        }
        else if selected_Unit == "cups"{
            return volumeOfUnit * 4.23
        }
        else if selected_Unit == "pints"{
            return volumeOfUnit * 2.11
        }
        else{
            return volumeOfUnit * 0.264
        }
    }
    
    var inMilliliters: Double{
        if selected_Unit == "liters"
        {
            return volumeOfUnit / 1000
        }
        else if selected_Unit == "milliliters"{
            return volumeOfUnit
        }
        else if selected_Unit == "cups"{
            return volumeOfUnit * 0.00423
        }
        else if selected_Unit == "pints"{
            return volumeOfUnit * 0.00211
        }
        else{
            return volumeOfUnit * 0.000264
        }
    }
    
    var inCups: Double{
        if selected_Unit == "liters"
        {
            return volumeOfUnit * 0.237
        }
        else if selected_Unit == "milliliters"{
            return volumeOfUnit * 237.588
        }
        else if selected_Unit == "cups"{
            return volumeOfUnit
        }
        else if selected_Unit == "pints"{
            return volumeOfUnit * 0.5
        }
        else{
            return volumeOfUnit * 0.0625
        }
    }
    
    var inPints: Double{
        if selected_Unit == "liters"
        {
            return volumeOfUnit * 0.473
        }
        else if selected_Unit == "milliliters"{
            return volumeOfUnit * 473
        }
        else if selected_Unit == "cups"{
            return volumeOfUnit * 2
        }
        else if selected_Unit == "pints"{
            return volumeOfUnit
        }
        else{
            return volumeOfUnit * 0.125
        }
    }
    
    var inGallons: Double{
        if selected_Unit == "liters"
        {
            return volumeOfUnit * 3.785
        }
        else if selected_Unit == "milliliters"{
            return volumeOfUnit * 378.5
        }
        else if selected_Unit == "cups"{
            return volumeOfUnit * 16
        }
        else if selected_Unit == "pints"{
            return volumeOfUnit * 32
        }
        else{
            return volumeOfUnit
        }
    }
    var body: some View {
        VStack {
            NavigationView{
                Form{
                    Section{
                        TextField("Enter your number of selected unit", value: $volumeOfUnit, format: .number)
                            .frame(minHeight: 50.0)
                        
                    } header: {
                        Text("Unit to Convert")
                    }
                    
                    Picker("Pick a Volume", selection: $selected_Unit) {
                        ForEach(volumes, id: \.self){
                            Text("\($0)").tag($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Section{
                        HStack{
                            Text("\(String(format: "%.3f", inLiters)) Liters")
                            Spacer()
                            Text("\(String(format: "%.3f",inMilliliters)) Milliliters")
                        }
                        .padding([.leading, .trailing])
                        
                        HStack{
                            Text("\(String(format: "%.3f",inCups)) Cups")
                            Spacer()
                            Text("\(String(format: "%.3f",inPints)) Pints")
                        }
                        .padding([.leading, .trailing])
                        
                        HStack{
                            Spacer()
                            Text("\(String(format: "%.3f", inGallons)) Gallons")
                            Spacer()
                        }
                    }
                }
                .navigationTitle("Volume Convertion")
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
