//
//  user.swift
//  SwiftUI Day 60
//
//  Created by Deye Lei on 11/18/22.
//

import Foundation

struct user: Codable, Identifiable{
    var id:String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email:String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [friend]
}

struct friend: Codable, Identifiable{
    var id:String
    var name: String
}
