//
//  playground1.swift
//  SwiftUI Day 45
//
//  Created by Deye Lei on 11/2/22.
//
import SwiftUI
import Foundation

struct playground1: View {
    @State var amount = 0.0
    var body: some View {
        VStack {
                    ZStack {
                        Circle()
                            .fill(.red)
                            .frame(width: 200 * amount)
                            .offset(x: -50, y: -80)
                            .blendMode(.screen)

                        Circle()
                            .fill(.green)
                            .frame(width: 200 * amount)
                            .offset(x: 50, y: -80)
                            .blendMode(.screen)

                        Circle()
                            .fill(.blue)
                            .frame(width: 200 * amount)
                            .blendMode(.screen)
                    }
                    .frame(width: 300, height: 300)

                    Slider(value: $amount)
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.black)
                .ignoresSafeArea()
        
        NavigationLink {
            playground2()
        } label: {
            Text("tap me")
                .foregroundColor(.white)
        }

    }
}

struct playground1_Previews: PreviewProvider {
    static var previews: some View {
        playground1()
    }
}
