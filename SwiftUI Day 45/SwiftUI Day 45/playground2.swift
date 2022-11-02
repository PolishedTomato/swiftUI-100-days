//
//  playground2.swift
//  SwiftUI Day 45
//
//  Created by Deye Lei on 11/2/22.
//
import SwiftUI
import Foundation

struct Trapezoid: Shape {
    var insetAmount: Double

    var animatableData: Double {
        get {insetAmount}
        set {insetAmount = newValue}
    }
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        //path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        path.closeSubpath()
        return path
   }
}

struct playground2: View {
    @State private var amount = 20.0
    
    var body: some View {
        VStack{
            Trapezoid(insetAmount: amount)
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                .frame(width: 300, height: 300)
                .onTapGesture {
                    withAnimation(.interpolatingSpring(stiffness: 60, damping: 2).repeatCount(3, autoreverses: true)) {
                        amount = Double.random(in: 0...50)
                    }
                }
            NavigationLink {
                playground3()
            } label: {
                Text("Tap")
            }

        }
            
    }
}

struct playground2_Previews: PreviewProvider {
    static var previews: some View {
        playground2()
    }
}
