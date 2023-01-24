//
//  TextAlignment.swift
//  SwiftUI Day 92
//
//  Created by Deye Lei on 1/23/23.
//

import Foundation
import SwiftUI

extension VerticalAlignment{
    //custom alignment defined
    enum MyAlignment: AlignmentID{
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
        
        
    }
    
    static var myAlignment = VerticalAlignment(MyAlignment.self)
}

struct TextAlignment: View {
    var body: some View {
        HStack(alignment: .myAlignment, spacing: 0) {
                    Color.red.frame(height: 1)
            
                        Color.red.frame(height: 1)
                .alignmentGuide(.myAlignment) { d in
                    d[VerticalAlignment.center]
                }
            VStack(){
                Text("some text")
                    .border(.gray)
                Text("some text")
                    .border(.gray)
                Text("some text")
                    .border(.gray)
                
                Text("some text")
                    .border(.gray)
                    .alignmentGuide(.myAlignment) { d in
                        d[VerticalAlignment.center]
                    }
                Text("some text")
                    .border(.gray)
                Text("some text")
                    .border(.gray)
                Text("some text")
                    .border(.gray)
                Text("some text")
                    .border(.gray)
            }
            VStack{
                Text("some text 2")
                    .border(.gray)
            }
                    Color.red.frame(height: 1)
                }
        .frame(width: 600,height: 500)
        .border(.gray)
    }
}

struct TextAlignment_Previews: PreviewProvider {
    static var previews: some View {
        TextAlignment()
    }
}
