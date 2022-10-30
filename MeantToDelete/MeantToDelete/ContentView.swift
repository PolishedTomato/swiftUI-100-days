//
//  ContentView.swift
//  MeantToDelete
//
//  Created by Deye Lei on 10/30/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack {
                NavigationLink {
                    Text("sample")
                } label: {
                    Image(systemName: "plus")
                }
                .tint(.green)
                .buttonStyle(.borderedProminent)

                Button("Tap"){
                    
                }
                List(0..<3){
                    Text("\($0)")
                        .listRowBackground(Color.black)
                }
                .background(.green)
                
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
