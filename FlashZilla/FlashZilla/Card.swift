//
//  Card.swift
//  FlashZilla
//
//  Created by Deye Lei on 1/13/23.
//

import Foundation

struct Card: Codable, Identifiable{
    var prompt: String
    var answer: String
    var isTrue: Bool
    var id = UUID()
    
    
    static var example: Card{
        Card(prompt: "what is the first line of code that you wrote", answer: "Hello world", isTrue: true)
    }
}
