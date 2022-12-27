//
//  ContentView.swift
//  SwiftUI Day 79
//
//  Created by Deye Lei on 12/27/22.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = "One"

        var body: some View {
            TabView(selection: $selectedTab) {
                Text("Tab 1")
                    .onTapGesture {
                        selectedTab = "Two"
                    }
                    .tabItem {
                        Label("One", systemImage: "star")
                    }
                    .tag("One")

                Text("Tab 2")
                    .onTapGesture {
                        selectedTab = "One"
                    }
                    .tabItem {
                        Label("Two", systemImage: "circle")
                    }
                    .tag("Two")
            }
        }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
