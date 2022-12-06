//
//  Location.swift
//  SwiftUI Day 70
//
//  Created by Deye Lei on 12/6/22.
//

import Foundation
import MapKit

struct Location: Identifiable, Equatable, Codable{
    var id = UUID()
    var name: String
    var description: String
    var longitude: Double
    var latitude: Double
    var emojiMarker = Int.random(in: 0..<7)
    var coordinator: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static var example = Location(name: "Great Wall of China", description: "a giant big wall", longitude: 116.570374, latitude: 40.431908)
    
    static func ==(lhs: Location, rhs: Location)->Bool{
        return lhs.id == rhs.id
    }
}
