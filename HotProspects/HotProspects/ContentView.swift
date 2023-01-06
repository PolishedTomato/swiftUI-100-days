//
//  ContentView.swift
//  HotProspects
//
//  Created by Deye Lei on 12/27/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var prospects = Prospects()
    var body: some View {
        TabView{
            ProspectView(filterType: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            ProspectView(filterType: .contacted)
                .tabItem{
                    Label("Contact", systemImage: "checkmark.circle")
                }
            ProspectView(filterType: .uncontacted)
                .tabItem{
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            MeView()
                .tabItem{
                    Label("Me", systemImage: "person")
                }
        }
        .environmentObject(prospects)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(prospects: Prospects.sampleData)
    }
}
