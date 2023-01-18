//
//  ContentView.swift
//  SwiftUI Day 87
//
//  Created by Deye Lei on 1/11/23.
//

import SwiftUI
import Foundation

struct ContentView: View {
    let time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
                    .onReceive(time) { time in
                        print("\(time)")
                    }
                NavigationLink("scenePhrase") {
                    ScencPhrase()
                }
            }
            .padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
