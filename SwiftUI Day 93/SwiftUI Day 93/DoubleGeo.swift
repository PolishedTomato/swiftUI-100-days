//
//  DoubleGeo.swift
//  SwiftUI Day 93
//
//  Created by Deye Lei on 1/24/23.
//

import Foundation
import SwiftUI

struct DoubleGeo: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        GeometryReader { fullView in
            ScrollView {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(colors[index % 7])
                            .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

struct DoubleGeo_Previews: PreviewProvider {
    static var previews: some View {
        DoubleGeo()
    }
}
