//
//  RatingComponentView.swift
//  BookWorm
//
//  Created by Deye Lei on 11/11/22.
//

import SwiftUI
import Foundation

struct RatingComponentView: View {
    @Binding var rating: Int

    var label = ""

    var maximumRating = 5

    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            Spacer()
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                    }
            }
            Spacer()
        }
    }
}

struct RatingComponentView_Previews: PreviewProvider {
    static var previews: some View {
        RatingComponentView(rating: .constant(6))
    }
}
