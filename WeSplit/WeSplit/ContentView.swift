//
//  ContentView.swift
//  WeSplit
//
//  Created by Deye Lei on 10/7/22.
//

import SwiftUI

struct ContentView: View {
    var array = ["Mary", "Kim","Jin"]
    @State var x = "Mary"
    var body: some View {
        VStack {
            NavigationView{
                Form{
                    Section("some section", content: {Text("some text")})
                    Picker("Pick something", selection: $x){
                        ForEach(array, id: \.self){
                            x in Text(x)
                        }
                    }
                }
                .navigationTitle("WeSplit")
                .navigationBarTitleDisplayMode(.large)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
