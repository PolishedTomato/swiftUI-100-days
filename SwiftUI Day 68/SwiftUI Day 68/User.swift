//
//  File.swift
//  SwiftUI Day 68
//
//  Created by Deye Lei on 12/2/22.
//

import Foundation

struct User: Comparable{
    var firstName:String
    var lastName:String
    static func < (lhs: User, rhs: User) -> Bool {
        return lhs.lastName < rhs.firstName
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.lastName == rhs.lastName
    }
    
    
}
