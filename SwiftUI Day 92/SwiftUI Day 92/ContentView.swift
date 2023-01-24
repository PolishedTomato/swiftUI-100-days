//
//  ContentView.swift
//  SwiftUI Day 92
//
//  Created by Deye Lei on 1/23/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            //this alignment base on the baseline of last text even when they have different font
            HStack(alignment: .lastTextBaseline) {
                Text("Live")
                    .font(.caption)
                Text("long")
                Text("and")
                    .font(.title)
                NavigationLink {
                    TextAlignment()
                } label: {
                    Text("prosper")
                        .font(.largeTitle)
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
