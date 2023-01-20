//
//  ContentView_ViewModel.swift
//  FlashZilla
//
//  Created by Deye Lei on 1/19/23.
//

import Foundation

extension ContentView{
    @MainActor class ViewModel: ObservableObject{
        //use array type initalizer array(repeating:, count:)
        //[Card] is the type
        @Published var cards = [Card](repeating: Card.example, count: 10)
        
        //isActive will determine whether timer's fire should be count or not
        @Published var isActive = false
        @Published var score = 0
        @Published var showAlert = false
        @Published var timeRemain = 100
        @Published var showEditView = false
        @Published var index = 0
        
        func remove(){
            cards.removeLast()
            if(cards.isEmpty){
                isActive = false
                showAlert = true
            }
        }
        
        func guessWrong(){
            let card = cards[cards.count-1]
            let newCard = Card(prompt: card.prompt, answer: card.answer, isTrue: card.isTrue)
            cards.removeLast()
            objectWillChange.send()
            
            cards.insert(newCard, at: 0)
        }
        
        func resetCard(){
            if let data = UserDefaults.standard.data(forKey: "Cards"){
                guard let CARDS = try? JSONDecoder().decode([Card].self, from: data) else{
                    cards = [Card](repeating: Card.example, count: 5)
                    return
                }
                
                cards = CARDS
            }
            else{
                cards = [Card](repeating: Card.example, count: 5)
            }
            
            isActive = true
            timeRemain = 100
            score = 0
        }
        
        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
        //if data exist use it, if not, provide sample data
        init(){
            if let data = UserDefaults.standard.data(forKey: "Cards"){
                guard let CARDS = try? JSONDecoder().decode([Card].self, from: data) else{
                    cards = [Card](repeating: Card.example, count: 5)
                    return
                }
                
                cards = CARDS
            }
            else{
                cards = [Card](repeating: Card.example, count: 5)
            }
        }
    }
}
