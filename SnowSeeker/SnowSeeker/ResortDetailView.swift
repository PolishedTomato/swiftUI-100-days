//
//  ResortDetailView.swift
//  SnowSeeker
//
//  Created by Deye Lei on 1/30/23.
//

import Foundation
import SwiftUI

struct ResortDetailView: View {
    let resort: Resort
    var price:String{
        switch(resort.price){
        case 1:
            return "$"
        case 2:
            return "$$"
        default:
            return "$$$"
        }
    }
    
    var size:String{
        switch(resort.size){
        case 1:
            return "small"
        case 2:
            return "median"
        default:
            return "large"
        }
    }
    
    var body: some View {
        Group {
                VStack {
                    Text("Size")
                        .font(.caption.bold())
                    Text(size)
                        .font(.title3)
                }

                VStack {
                    Text("Price")
                        .font(.caption.bold())
                    Text(price)
                        .font(.title3)
                }
            }
            .frame(maxWidth: .infinity)
    }
}

struct ResortDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ResortDetailView(resort: Resort.example)
    }
}
