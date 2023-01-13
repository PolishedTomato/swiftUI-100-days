//
//  CardView.swift
//  FlashZilla
//
//  Created by Deye Lei on 1/13/23.
//

import Foundation
import SwiftUI

struct CardView: View {
    let card: Card
    @State var isShowingAnswer = false
    @State var offset = CGSize.zero
    
    //take completion handle from parent
    var removal: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.white)
                .shadow(radius: 10)

            VStack {
                if !isShowingAnswer{
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                }
                else if isShowingAnswer {
                    Text(card.answer)
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width) / 20))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .scaleEffect(abs(offset.width) >= 50 ? abs(50 / offset.width) : 1)
        .gesture(
            DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                    }
                    .onEnded { _ in
                        if abs(offset.width) > 100 {
                            removal?()
                        } else {
                            offset = .zero
                        }
                    }
            
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .rotation3DEffect(isShowingAnswer ? Angle(degrees: 360) : Angle(degrees: 0), axis:(x: 0, y:1, z:0))
        .animation(.easeInOut, value: isShowingAnswer)
        //animation only work when the animation modifier using the value that was watched, then it examine the changes and apply animation
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
