//
//  SkiDetailView.swift
//  SnowSeeker
//
//  Created by Deye Lei on 1/30/23.
//

import Foundation
import SwiftUI

struct SkiDetailView: View {
    let resort : Resort
    var body: some View {
        //this group will have two VStack inside is because we gonna place this view inside HStack
        Group{
            VStack{
                Text("Elevation")
                    .font(.caption.bold())
                Text("\(resort.elevation)")
                    .font(.title3)
            }
            
            VStack{
                Text("Snow")
                    .font(.caption.bold())
                Text("\(resort.snowDepth)")
                    .font(.title3)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct SkiDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SkiDetailView(resort: Resort.example)
    }
}
