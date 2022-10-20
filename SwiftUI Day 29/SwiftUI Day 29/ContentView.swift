//
//  ContentView.swift
//  SwiftUI Day 29
//
//  Created by Deye Lei on 10/20/22.
//

import SwiftUI

struct ContentView: View {
    func some_func() -> Bool{
        let word = "swift"
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspell = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        let x = misspell.location == NSNotFound
        
        
        
        return x
    }
    
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
            
            if(some_func()){
                Text("no spell error")
            }
            else{
                Text("There is a spell error")
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
