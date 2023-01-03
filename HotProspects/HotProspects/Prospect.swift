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
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    let saveKey = "SavedData"
    init() {
        if let savedData = UserDefaults.standard.data(forKey: saveKey){
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: savedData){
                people = decoded
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
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    func toggleContacted(target: Prospect){
        self.objectWillChange.send()
        target.isContacted.toggle()
        save()
    }
}
