//
//  ContentView.swift
//  SwiftUI Day 74
//
//  Created by Deye Lei on 12/20/22.
//

import SwiftUI

struct ContentView: View {
    let pictures = [
            "ales-krivec-15949",
            "galina-n-189483",
            "kevin-horstmann-141705",
            "nicolas-tissot-335096"
        ]

    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks",
    ]
        @State private var selectedPicture = Int.random(in: 0...3)
        @State private var value = 0
        var body: some View {
            VStack{
                Image(decorative: pictures[selectedPicture])
                    .resizable()
                    .scaledToFit()
                    .onTapGesture {
                        selectedPicture = Int.random(in: 0...3)
                    }
                    .accessibility(label: Text("\(labels[selectedPicture])"))
                    .accessibilityHint(Text("Beautiful imags"))
                    .accessibilityAddTraits(.isButton)
                    .accessibilityRemoveTraits(.isImage)
            }
            VStack {
                Text("Value: \(value)")

                Button("Increment") {
                    value += 1
                }

                Button("Decrement") {
                    value -= 1
                }
            }
            .accessibilityElement()
            .accessibilityLabel("Value")
            .accessibilityValue(String(value))
            .accessibilityAdjustableAction { direction in
                switch direction {
                case .increment:
                    value += 1
                case .decrement:
                    value -= 1
                default:
                    print("Not handled.")
                }
            }
            Stepper("Dosomehting", value: $value)
                .accessibilityAdjustableAction { direction in
                    switch direction{
                    case .increment: value += 1
                    case .decrement: value -= 1
                    default: print("not handle")
                    }
                }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
