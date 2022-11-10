//
//  DataController.swift
//  SwiftUI Day 53
//
//  Created by Deye Lei on 11/10/22.
//

import CoreData
import Foundation

class DataController: ObservableObject{
    //prepare for loading data with data model(defintion of our data)
    let container = NSPersistentContainer(name: "BookWorm")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
