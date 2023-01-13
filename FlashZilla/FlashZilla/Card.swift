//
//  Card.swift
//  FlashZilla
//
//  Created by Deye Lei on 1/13/23.
//

import Foundation

struct Card{
    var prompt: String
    var answer: String
    
    static var example: Card{
        Card(prompt: "what is the first line of code that you wrote", answer: "Hello world")
    }
}
