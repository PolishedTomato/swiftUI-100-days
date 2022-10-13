//
//  ContentView.swift
//  ViewAndModifier
//
//  Created by Deye Lei on 10/13/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Button("Hello, world!") {
                // do nothing
            }
            .background(.red)
            .frame(width: 200, height: 200)
            .font(.largeTitle)
            
            VStack {
                Text("Gryffindor")
                    .blur(radius: 0)
                Text("Hufflepuff")
                Text("Ravenclaw")
                Text("Slytherin")
            }
            .blur(radius: 5)
        }
        .padding()
        .buttonStyle(.bordered)
        .border(.red)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
