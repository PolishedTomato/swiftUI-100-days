//
//  Classes.swift
//  SwiftUI Day 49
//
//  Created by Deye Lei on 11/7/22.
//

import Foundation

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}
