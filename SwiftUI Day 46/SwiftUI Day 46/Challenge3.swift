//
//  File.swift
//  SwiftUI Day 46
//
//  Created by Deye Lei on 11/3/22.
//
import SwiftUI
import Foundation

struct RectangleGradiant: View{
    var StartPoint: UnitPoint
    var endPoint: UnitPoint
    
    let myColors = [Color.red, Color.green, Color.blue]
    var body: some View{
        ZStack{
            ForEach(0..<3,  id: \.self) {
                Rectangle()
                    .inset(by: Double($0)*30)
                    .strokeBorder(
                        LinearGradient(colors: [myColors[$0%3],myColors[($0+1)%3],myColors[($0+2)%3]], startPoint: StartPoint, endPoint: .bottom)
                        ,style: StrokeStyle(lineWidth: 10, lineJoin: .round)
                    )
            }
        }
    }
}

struct Challenge3: View {
    @State private var xy: UnitPoint = UnitPoint(x: 0, y: 0)
    @State private var xy2: UnitPoint = UnitPoint(x: 1.0, y: 1.0)
    //@State private var coordinates = (UnitPoint(x: 0.0, y: 0.0), UnitPoint(x: 1.0, y: 1.0))
    var body: some View {
        RectangleGradiant(StartPoint: xy, endPoint: xy2)
            .frame(width:300, height: 200)
            .onTapGesture {
                xy = UnitPoint(x: Double.random(in: 0...1), y: Double.random(in: 0...1))
                //xy2 = UnitPoint(x: Double.random(in: 0...1), y: Double.random(in: 0...1))
                //xy = UnitPoint(x: 0.5, y: 0.5)
            }
            .animation(.interpolatingSpring(stiffness: 200, damping: 1).repeatCount(3,autoreverses: false), value: xy)
    }
}

struct Challenge3_Previews: PreviewProvider {
    static var previews: some View {
        Challenge3()
    }
}
