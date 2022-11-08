//
//  ActivityLabelView.swift
//  ActivityTracker
//
//  Created by Deye Lei on 11/4/22.
//

import SwiftUI
import Foundation

struct ActivityLabelView: View {
    let name: String
    var body: some View {
        ZStack{
            Color.pink
                .clipShape(Capsule())
            Text(name)
                .font(.title.weight(.bold))
                .foregroundColor(.black)
        }
        .frame(width: 150, height: 100)
    }
}

struct ActivityLabelView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityLabelView(name: "bac")
    }
}
