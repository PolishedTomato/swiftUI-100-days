//
//  ContentView.swift
//  SwiftUI Day 45
//
//  Created by Deye Lei on 11/2/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            ZStack{
                Image("dog")
                    .resizable()
                    .scaledToFit()
                //.colorMultiply(.red) same thing with below
                Color(.red)
                    .blendMode(.hue)
            }
            NavigationView{
                NavigationLink {
                    playground1()
                } label: {
                    Text("Tap")
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
