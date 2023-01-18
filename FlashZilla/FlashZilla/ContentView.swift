//
//  ContentView.swift
//  FlashZilla
//
//  Created by Deye Lei on 1/13/23.
//
import Foundation
import SwiftUI

struct ContentView: View {
    //use array type initalizer array(repeating:, count:)
    //[Card] is the type
    @State var cards = [Card](repeating: Card.example, count: 10)
    @Environment(\.accessibilityDifferentiateWithoutColor) var colorBlindness
    @Environment(\.scenePhase) var scene
    //isActive will determine whether timer's fire should be count or not
    @State var isActive = true
    
    func remove(at index: Int){
        cards.remove(at: index)
        if(cards.isEmpty){
            isActive = false
        }
    }
    
    func resetCard(){
        cards = [Card](repeating: Card.example, count: 10)
        isActive = true
        timeRemain = 100
        score = 0
    }
    
    @State var timeRemain = 5
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var score = 0
    
    var gameEnd: Bool{
        cards.isEmpty || timeRemain == 0
    }
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
                VStack {
                    if colorBlindness {
                        HStack{
                            Image(systemName: "xmark.seal")
                                .padding()
                                .frame(width: 50, height: 50)
                            Spacer()
                            Image(systemName: "checkmark.seal")
                                .frame(width: 50, height: 50)
                                .padding()
                                
                        }
                        .padding(.horizontal)
                        .foregroundColor(.white)
                        .font(.title)
                    }
                    
                    Text("Time remain: \(timeRemain)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    
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
                    .allowsHitTesting(timeRemain > 0)
                }
            
            if gameEnd {
                ZStack{
                    RoundedRectangle(cornerRadius: 25, style: .circular)
                        .fill(.white)
                    VStack{
                        Text("Your Score is \(score)")
                            .padding()
                        Spacer()
                        Button("Retry"){
                            resetCard()
                        }
                    }
                    .font(.title)
                    .foregroundColor(.black)
                    
                }
                .frame(width: 350, height: 150)
                .background(.secondary)
                .shadow(radius: 15)
            }
            }
            .onReceive(timer) { time in
                guard isActive == true else {return}
                
                if(timeRemain > 0){
                    timeRemain -= 1
                }
            }
            .onChange(of: scene) { newValue in
                if newValue == .active {
                    if cards.isEmpty == false{
                        isActive = true
                    }
                }
                else{
                    isActive = false
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
