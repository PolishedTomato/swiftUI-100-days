//
//  Prospect.swift
//  HotProspects
//
//  Created by Deye Lei on 12/30/22.
//

import Foundation

class Prospect: Identifiable, Codable{
    var id = UUID()
    var name = ""
    var email = ""
    var connectedTime = Date.now
    var lat = 0.1
    var lon = 0.1
    
    fileprivate(set) var isContacted = false
    
    init(){
        
    }
    
    init(name: String, email:String, connectedTime: Date, lat:Double, lon: Double){
        self.name = name
        self.email = email
        self.connectedTime = connectedTime
        self.lat = lat
        self.lon = lon
    }
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    let saveKey = "SavedData"
    init() {
        /*//save by userdefault
        if let savedData = UserDefaults.standard.data(forKey: saveKey){
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: savedData){
                people = decoded
                return
            }
        }*/
        //save by file
        if let data = try? Data(contentsOf: FileManager.savedPath){
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data){
                people = decoded
                print("decode success")
                return
            }
        }
        
        self.people = []
    }
    
    func add(newProspect: Prospect){
        people.append(newProspect)
        save()
    }
    
    private func save(){
        if let encoded = try? JSONEncoder().encode(people){
            do {
                try encoded.write(to: FileManager.savedPath)
                print("save to file success")
            }
            catch{
                print(error)
            }
        }
    }
    
    func toggleContacted(target: Prospect){
        self.objectWillChange.send()
        target.isContacted.toggle()
        save()
    }
}

extension Prospects{
    static var sampleProspects: [Prospect]{
        return [Prospect(name: "People1", email: "person1@gmail.com", connectedTime: Date(timeInterval: 10, since: Date.now), lat: 40.7520, lon: -73.9946),
                Prospect(name: "People2", email: "person2@gmail.com",connectedTime: Date(timeInterval: 5, since: Date.now),lat: 40.594923,lon:-73.956108),
                Prospect(name: "people3", email: "person3@gamil.com", connectedTime: Date(timeInterval: 1, since: Date.now), lat: 40.8, lon: -74)]
    }
    static var sampleData:Prospects{
        let data = Prospects()
        data.people = sampleProspects
        return data
    }
}
