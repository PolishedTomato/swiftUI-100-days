//
//  Favorite.swift
//  SnowSeeker
//
//  Created by Deye Lei on 1/31/23.
//

import Foundation

class Favorites: ObservableObject {
    // the actual resorts the user has favorited
    private var resorts: Set<String>

    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"

    init() {
        // load our saved data
        if let data = try? Data(contentsOf: FileManager.savePath){
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data){
                resorts = decoded
                return
            }
        }
        // still here? Use an empty array
        resorts = []
    }

    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        if resorts.contains(resort.id){
            return true
        }
        return false
    }

    // adds the resort to our set, updates all views, and saves the change
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    // removes the resort from our set, updates all views, and saves the change
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

    func save() {
        // write out our data
        if let data = try? JSONEncoder().encode(resorts){
            do{
                try data.write(to: FileManager.savePath)
            }
            catch{
                print(error)
            }
        }
    }
}
