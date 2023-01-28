//
//  DiceView.swift
//  SwiftUI Day 95
//
//  Created by Deye Lei on 1/26/23.
//

import Foundation
import SwiftUI

struct DiceView: View {
    let value: Int
    let color: Color
    @State var flip = true
    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 20.0, style: .continuous)
                    .foregroundColor(.green)
                VStack{
                    Text(String(value))
                        .font(.title.bold())
                }
            }
            .frame(width: 50, height: 50)
            .rotation3DEffect(flip ? .degrees(360) : .degrees(0), axis: (x: 0, y: 1, z: 0))
            .animation(.default, value: flip)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Dice value of \(value)")
            /*Button("rotate"){
                flip.toggle()
            }*/
        }
        .onAppear{
            flip.toggle()
        }
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(value: 5,color: .green)
    }
}
