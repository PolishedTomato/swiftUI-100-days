//
//  Activities.swift
//  ActivityTracker
//
//  Created by Deye Lei on 11/4/22.
//

import Foundation

struct Activity:Identifiable, Codable{
    var name: String
    var startTime: Date
    var endTime: Date
    var id = UUID()
}

class Activities: ObservableObject{
    static var sampleData = [
        Activity(name: "go to sleep", startTime: Date(timeIntervalSince1970: 1000), endTime: Date(timeIntervalSince1970: 20000)),
        Activity(name: "Run!", startTime: Date(timeIntervalSince1970: 3000), endTime: Date(timeIntervalSince1970: 20000)),
        Activity(name: "Relax", startTime: Date(timeIntervalSince1970: 4000), endTime: Date(timeIntervalSince1970: 20000))]
    
    static func sample() -> Activities{
        let activities = Activities()
        activities.activities = sampleData
        
        return activities
    }
    
    @Published var activities: [Activity] = []{
        didSet{
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(activities){
                UserDefaults.standard.set(data,forKey: "data")
            }
        }
    }

    init(){
        if let data = UserDefaults.standard.data(forKey: "data"){
            let decoder = JSONDecoder()
            if let content = try? decoder.decode([Activity].self, from: data){
                activities = content
            }
        }
    }
}
