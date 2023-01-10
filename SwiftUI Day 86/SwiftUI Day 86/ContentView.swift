//
//  ContentView.swift
//  SwiftUI Day 86
//
//  Created by Deye Lei on 1/10/23.
//

import SwiftUI

struct ContentView: View {
    @State var currentAmount = Angle.zero
    @State var finalAmount = Angle.zero
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Hello, World!")
                    .onLongPressGesture(minimumDuration: 1) {
                        print("Long pressed!")
                    } onPressingChanged: { inProgress in
                        print("In progress: \(inProgress)!")
                    }
                Text("Hello, World!")
                    .rotationEffect(currentAmount + finalAmount)
                    .gesture(
                        RotationGesture()
                            .onChanged { angle in
                                currentAmount = angle
                            }
                            .onEnded { angle in
                                finalAmount += currentAmount
                                currentAmount = .zero
                            }
                    )
                
                NavigationLink("More gesture") {
                    moreGesture()
                }
                NavigationLink("Hapic"){
                    Hapic()
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
