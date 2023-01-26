//
//  ContentView.swift
//  SwiftUI Day 93
//
//  Created by Deye Lei on 1/24/23.
//

import SwiftUI

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(.green)
            Text("Bottom")
        }
    }
}
//geometryProxy can read the frame of its parent(local), device(global), or any parent(custom using Coordinate space) view in the view hierarchy

//
struct InnerView: View {
    var body: some View {
        NavigationView{
            HStack {
                Text("Left")
                GeometryReader { geo in
                    VStack{
                        GeometryReader{ textGeo in
                        Text("Center")
                            .background(.blue)
                            .onTapGesture {
                                print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                                print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                                print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                                print("Text geo is \(textGeo.frame(in: .global).midX) x \(textGeo.frame(in: .global).midY)")
                            }
                            }
                        NavigationLink {
                            DoubleGeo()
                        } label: {
                            Text("Tap to go to second double geometry read in action")
                        }
                    }
                }
                .background(.orange)
                Text("Right")
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        OuterView()
            .background(.red)
            .coordinateSpace(name: "Custom")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
