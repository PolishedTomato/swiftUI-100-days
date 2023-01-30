//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Deye Lei on 1/30/23.
//

import Foundation
import SwiftUI



struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}

struct ResortView: View {
    let resort: Resort

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                    
                HStack{
                    SkiDetailView(resort: resort)
                    ResortDetailView(resort: resort)
                }
                .padding(.vertical)
                .background(.green
                )
                
                Group {
                    Text(resort.description)
                        .padding(.vertical)

                    Text("Facilities")
                        .font(.headline)

                    Text(resort.facilities, format: .list(type: .and))
                        .padding(.vertical)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
    }
}


