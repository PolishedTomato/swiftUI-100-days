//
//  ContentView.swift
//  SwiftUI Day 32
//
//  Created by Deye Lei on 10/22/22.
//

import SwiftUI

struct ContentView: View {
    @State private var animationSize = 1.0
    @State private var animationSize2 = 1.0
    @State private var animationAmount = 0.0

    var body: some View {
        VStack {
            Button("Tap me", role: .cancel){
                animationSize += 1.0
            }
            .buttonStyle(.borderedProminent)
            .background(.green)
            .padding()
            .clipShape(Circle())
            .scaleEffect(animationSize)
            .animation(.easeInOut.repeatCount(3, autoreverses: false), value: animationSize)
            
            //interesting pulsing animation
            //this animation will be keep alive for the repeatForever modifier on animationType
            Button("Tap me", role: .cancel){
                
            }
            .buttonStyle(.borderedProminent)
            .background(.green)
            .padding()
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(.red)
                    .scaleEffect(animationSize)
                    .opacity(2 - animationSize)
                    .animation(
                        .easeOut(duration: 1)
                            .repeatForever(autoreverses: false),
                        value: animationSize
                    )
            )
            .onAppear(perform: {animationSize = 2})
            
            //animation on blinding value
            Stepper("", value:
                        $animationSize2.animation(.easeInOut
                            .repeatCount(3,autoreverses: true))
            , in: 0...3)
            Button("tap me 3"){
                
            }
            .padding(20)
            .clipShape(Rectangle())
            .background(.green)
            .foregroundColor(.white)
            
            Button("tap me 4"){
                withAnimation{
                    animationAmount += 360
                }
            }
            .padding(50)
            .clipShape(Circle())
            .background(.pink)
            .foregroundColor(.white)
            .rotation3DEffect(Angle(degrees: animationAmount), axis: (x:1.0, y: 1.0, z: 0))
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
