//
//  ContentView.swift
//  SwiftUI Day 62
//
//  Created by Deye Lei on 11/22/22.
//

import SwiftUI

struct ContentView: View {
    @State var blurAmount = 0.0 {
        
        didSet {
            print("New value is \(blurAmount)")
        }
    }
    @State var backgroundColor = Color.red
    @State var showingConfirmation = false
    var body: some View {
        VStack {
                    Text("Hello, World!")
                        .blur(radius: blurAmount)

                    Slider(value: $blurAmount, in: 0...20)

                    Button("Random Blur") {
                        blurAmount = Double.random(in: 0...20)
                    }
            
            Text("Hello, World!")
                        .frame(width: 300, height: 300)
                        .background(backgroundColor)
                        .onTapGesture {
                            showingConfirmation = true
                        }
                        .confirmationDialog("confirmation", isPresented: $showingConfirmation) {
                            Button("Ok"){
                                
                            }
                            Button("Not ok"){
                                
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
