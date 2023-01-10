//
//  moreGesture.swift
//  SwiftUI Day 86
//
//  Created by Deye Lei on 1/10/23.
//

import Foundation
import SwiftUI

struct moreGesture: View {
    @State var isDragging = false
    @State var offset = CGSize.zero
    var body: some View {
        
        // a drag gesture that updates offset and isDragging as it moves around
                let dragGesture = DragGesture()
                    .onChanged { value in offset = value.translation }
                    .onEnded { _ in
                        withAnimation {
                            offset = .zero
                            isDragging = false
                        }
                    }

                // a long press gesture that enables isDragging
                let pressGesture = LongPressGesture()
                    .onEnded { value in
                        withAnimation {
                            isDragging = true
                        }
                    }

                // a combined gesture that forces the user to long press then drag
                let combined = pressGesture.sequenced(before: dragGesture)

                // a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
                Circle()
                    .fill(.red)
                    .frame(width: 64, height: 64)
                    .scaleEffect(isDragging ? 1.5 : 1)
                    .offset(offset)
                    .gesture(combined)
            }
    }



struct moreGesture_Previews: PreviewProvider {
    static var previews: some View {
        moreGesture()
    }
}
