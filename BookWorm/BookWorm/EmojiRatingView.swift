//
//  EmojiRatingView.swift
//  BookWorm
//
//  Created by Deye Lei on 11/11/22.
//

import SwiftUI
import Foundation

struct EmojiRatingView: View {
    let rating: Int16
    var body: some View {
        switch rating{
        case 1:
            Text("🐼")
        case 2:
            Text("🐹")
        case 3:
            Text("🦮")
        case 4:
            Text("🤩")
        case 5:
            Text("🦊")
        default:
            Text("🐼")
        }
    }
}

struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView(rating: Int16(2))
    }
}
