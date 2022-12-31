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
    @Published var people: [Prospect]

    init() {
        self.people = []
    }
    
    func toggleContacted(target: Prospect){
        self.objectWillChange.send()
        target.isContacted.toggle()
    }
}
