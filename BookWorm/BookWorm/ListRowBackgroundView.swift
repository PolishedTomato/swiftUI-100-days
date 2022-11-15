//
//  ListRowBackgroundView.swift
//  BookWorm
//
//  Created by Deye Lei on 11/15/22.
//

import SwiftUI
import Foundation

//challenge two complete
struct ListRowBackgroundView: View {
    let rating: Int16
    var body: some View {
        Color(red: rating == 1 ? 1 : 0, green: rating == 5 ? 1: 0, blue: 0)
            .clipShape(
                Rectangle()
                    .stroke(style: StrokeStyle(lineWidth: 10))
            )
    }
}

struct ListRowBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowBackgroundView(rating: Int16(1))
    }
}
