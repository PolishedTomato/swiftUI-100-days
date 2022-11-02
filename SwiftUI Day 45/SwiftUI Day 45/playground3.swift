//
//  playground3.swift
//  SwiftUI Day 45
//
//  Created by Deye Lei on 11/2/22.
//
import SwiftUI
import Foundation

struct Checkerboard: Shape {
    var rows: Int
    var columns: Int
    var thrid: Double
    
    var animatableData: AnimatablePair<AnimatablePair<Double, Double>,Double>{
        get{AnimatablePair(AnimatablePair(Double(rows), Double(columns)), thrid)}
        set{
            rows = Int(newValue.first.first)
            columns = Int(newValue.first.second)
            thrid = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // figure out how big each row/column needs to be
        let rowSize = rect.height / Double(rows)
        let columnSize = rect.width / Double(columns)

        // loop over all rows and columns, making alternating squares colored
        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2) {
                    // this square should be colored; add a rectangle here
                    let startX = columnSize * Double(column)
                    let startY = rowSize * Double(row)

                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }

        return path
    }
}

struct playground3: View {
    @State private var rows = 4
    @State private var columns = 8
    @State private var thrid = 3.0
    var body: some View {
        Checkerboard(rows: rows, columns: columns, thrid: thrid)
                    .onTapGesture {
                        withAnimation(.linear(duration: 3)) {
                            rows = 8
                            columns = 16
                            thrid = 4.0
                        }
                    }
    }
}

struct playground3_Previews: PreviewProvider {
    static var previews: some View {
        playground3()
    }
}
