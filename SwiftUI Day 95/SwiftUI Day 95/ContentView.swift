//
//  ContentView.swift
//  SwiftUI Day 95
//
//  Created by Deye Lei on 1/26/23.
//

import SwiftUI

struct ContentView: View {
    @State private var numberDice = 1
    @State private var numberOfSide = 6
    
    var body: some View {
        NavigationView {
            Form{
                Stepper("Select \(numberDice) of dices to roll", value: $numberDice, in: 1...6)
                Stepper("Select \(numberOfSide) of side for dices", value: $numberOfSide, in: 2...12)
                
                NavigationLink {
                    DiceRollView(numberDice: numberDice, numberSide: numberOfSide)
                } label: {
                    Label("Press to start", image: "gamecontroller")
                }

            }
            .navigationTitle("RollDice")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
