//
//  ContentView.swift
//  SwiftUI Day 43
//
//  Created by Deye Lei on 10/31/22.
//

import SwiftUI

struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool

    var insetAmount = 0.0
    
    var modifiedStartAngle: Angle{
        startAngle - Angle(degrees: 90)
    }
    
    var modifiedEndAngle: Angle{
        endAngle - Angle(degrees: 90)
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStartAngle, endAngle: modifiedEndAngle, clockwise: !clockwise)

        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct Triangle: Shape{
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}

//lineCap specify how line should end, lineJoin specify how line are join
struct ContentView: View {
    var body: some View {
        VStack{
            Path{
                path in
                path.move(to: CGPoint(x: 100, y: 100))
                path.addLine(to: CGPoint(x: 50, y: 50))
                path.addLine(to: CGPoint(x: 50, y: 150))
                path.addLine(to: CGPoint(x: 100, y: 100))
            }
            .stroke(.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
            
            
            Triangle()
                .stroke(.red, style: StrokeStyle(lineWidth: 30,lineCap:.round, lineJoin: .round))
                .padding(50)
            
            Arc(startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: true)
                .strokeBorder(style: StrokeStyle(lineWidth: 50))
                
            
        }
        
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
