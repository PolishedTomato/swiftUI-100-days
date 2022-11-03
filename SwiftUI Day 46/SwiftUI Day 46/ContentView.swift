//
//  ContentView.swift
//  SwiftUI Day 46
//
//  Created by Deye Lei on 11/3/22.
//

import SwiftUI

struct Arrow: Shape{
    var lineThick: Double
    
    var animatableData: Double{
        get{
            return lineThick
        }
        set{
            lineThick = newValue
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.maxX/2, y: rect.maxY/2))
        path.addLine(to: CGPoint(x: rect.maxX/2, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY/2))
        path.addLine(to: CGPoint(x: rect.maxX/2, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX/2, y: rect.maxY/2))
        
        path.addRect(CGRect(x: 0, y: Int(rect.maxY)/2-10, width: Int(rect.maxX)/2, height: 20))
        return path
    }
}

struct ContentView: View {
    @State private var lineThick = 2.0
    var body: some View {
        VStack{
            Arrow(lineThick: lineThick)
                .stroke(.blue, style: StrokeStyle(lineWidth: lineThick, lineCap: .round, lineJoin: .round))
                .frame(width:300, height: 200)
                .onTapGesture {
                    lineThick = Double.random(in: 1...10)
                }
                .animation(.interpolatingSpring(stiffness: 50, damping: 3).repeatCount(3, autoreverses: true), value: lineThick)
            
            Slider(value: $lineThick, in: 1...10)
            
            Challenge3()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
