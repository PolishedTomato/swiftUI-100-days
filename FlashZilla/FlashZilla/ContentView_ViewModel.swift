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
        @Published var isActive = true
        @Published var score = 0
        @Published var showAlert = false
        @Published var timeRemain = 5
        @Published var showEditView = false
        
        func remove(at index: Int){
            cards.remove(at: index)
            if(cards.isEmpty){
                isActive = false
                showAlert = true
            }
        }
        
        func resetCard(){
            cards = [Card](repeating: Card.example, count: 10)
            isActive = true
            timeRemain = 100
            score = 0
        }
        
        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
    }
}
