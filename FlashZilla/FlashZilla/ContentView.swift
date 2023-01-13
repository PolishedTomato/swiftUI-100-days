//
//  ContentView.swift
//  FlashZilla
//
//  Created by Deye Lei on 1/13/23.
//

import SwiftUI

struct ContentView: View {
    //use array type initalizer array(repeating:, count:)
    //[Card] is the type
    @State var cards = [Card](repeating: Card.example, count: 10)
    
    func remove(at index: Int){
        cards.remove(at: index)
    }
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
                VStack {
                    ZStack {
                        ForEach(0..<cards.count, id: \.self) { index in
                            CardView(card: cards[index]){
                                withAnimation{
                                    remove(at: index)
                                }
                            }
                            .stacked(at: index, in: cards.count)
                        }
                    }
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}
