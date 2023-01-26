//
//  ContentView.swift
//  SwiftUI Day 94
//
//  Created by Deye Lei on 1/25/23.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            //challenge 3
                            .background(Color(hue: geo.frame(in: .global).midY / fullView.size.height, saturation: 0.8, brightness: 0.8))
                            .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .opacity(2 - Double(abs(geo.frame(in: .global).midY - fullView.size.height * 0.5) / (fullView.size.height * 0.3)))
                        //challenge 2
                            .scaleEffect(geo.frame(in: .global).midY / fullView.size.height + 0.5)
                            .onTapGesture {
                                //challenge1, only when over the fullView's 0.3 distance start from the middle will it fade out
                                print(2 - Double(abs(geo.frame(in: .global).midY - fullView.size.height * 0.5) / (fullView.size.height * 0.2)))
                                print("the midY is: \(geo.frame(in: .global).midY)")
                                print("the fullView height is: \(fullView.size.height)")
                            }
                    }
                    .frame(height: 40)
                }
            }
        }
        .border(.gray)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
