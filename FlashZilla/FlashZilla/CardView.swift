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
    @State var generator = UINotificationFeedbackGenerator()
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var colorBlindness
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnable
    
    @Binding var score: Int
    //take completion handle from parent
    var removal: (() -> Void)? = nil
    var guessWrong: (()->Void)? = nil
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    colorBlindness ? .white :
                    .white
                        .opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    colorBlindness ? nil :
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fillRedGreen(width: offset.width)
                )
                .shadow(radius: 10)

            VStack {
                if voiceOverEnable {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)

                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
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
                        generator.prepare()
                    }
                    .onEnded { _ in
                        if offset.width > 100 {
                            if(card.isTrue == true){
                                print("guess it right")
                                score += 1
                                removal?()
                            }
                            else{
                                print("Guess it wrong")
                                guessWrong?()
                            }
                            //generator.notificationOccurred(.success)
                        }
                        else if offset.width < -100{
                            if(card.isTrue == false){
                                print("guess it right")
                                score += 1
                                removal?()
                            }
                            else{
                                print("Guess it wrong")
                                guessWrong?()
                            }
                        }
                        else {
                            offset = .zero
                            generator.notificationOccurred(.error)
                        }
                    }
            
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .rotation3DEffect(isShowingAnswer ? Angle(degrees: 360) : Angle(degrees: 0), axis:(x: 0, y:1, z:0))
        .animation(.easeInOut, value: isShowingAnswer)
        .animation(.spring(), value: offset)
        //animation only work when the animation modifier using the value that was watched, then it examine the changes and apply animation
        .accessibilityAddTraits(.isButton)
    }
}

//custom modifier on roundedRectagnle that change its color base on offset it goes
extension RoundedRectangle{
    func fillRedGreen(width: Double)->some View{
        if width == 0{
            return self.fill(.white)
        }
        else if width < 0 {
            return self.fill(.red)
        }
        else{
            return self.fill(.green)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example, score: .constant(0))
    }
}
