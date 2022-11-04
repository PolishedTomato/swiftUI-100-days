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
        VStack{
            Text(name)
                .font(.title.weight(.bold))
                .foregroundColor(.black)
        }
    }
}

struct ActivityLabelView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityLabelView(name: "bac")
    }
}
