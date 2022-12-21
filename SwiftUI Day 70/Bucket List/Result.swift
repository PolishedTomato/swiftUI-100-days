//
//  Result.swift
//  SwiftUI Day 70
//
//  Created by Deye Lei on 12/9/22.
//

import Foundation

//use this to decode wiki api result
struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable, Comparable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    
    static func <(lhs: Page, rhs: Page) -> Bool{
        return lhs.title < rhs.title
    }
    
    var description:String{
        terms?["description"]?.first ?? "No description"
    }
}
