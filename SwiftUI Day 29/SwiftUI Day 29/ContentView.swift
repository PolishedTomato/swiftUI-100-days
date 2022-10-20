//
//  ContentView.swift
//  SwiftUI Day 29
//
//  Created by Deye Lei on 10/20/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            List {
                Section("Section 1") {
                    Text("Static row 1")
                    Text("Static row 2")
                }
                
                Section("Section 2") {
                    ForEach(0..<5) {
                        Text("Dynamic row \($0)")
                    }
                }
                
                Section("Section 3") {
                    Text("Static row 3")
                    Text("Static row 4")
                }
            }.listStyle(.automatic)
            
            List(0..<3){
                Text("\($0) row")
            }
            
            
        }
        //.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
