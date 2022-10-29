//
//  Decode Class.swift
//  MoonShot
//
//  Created by Deye Lei on 10/28/22.
//
import SwiftUI
import Foundation

struct Astronaut :Codable, Identifiable{
    var id: String
    var name:String
    var description: String
}

struct Mission: Codable, Identifiable{
    
    struct CrewRole: Codable {
        let name:String
        let role:String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName:String{
        return "Apollo \(id)"
    }
    
    var image: String{
        return "apollo\(id)"
    }
    
    var formattedLaunchDate: String{
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}

extension ShapeStyle where Self == Color{
    static var darkBackground: Color {
        
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }
    
    static var lightBackground: Color{
        Color(red: 0.2, green: 0.2, blue: 0.2)
    }
}
