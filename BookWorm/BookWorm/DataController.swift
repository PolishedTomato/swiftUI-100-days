//
//  DataController.swift
//  BookWorm
//
//  Created by Deye Lei on 11/11/22.
//

import CoreData
import Foundation

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "BookWorm")
    
    init(){
        container.loadPersistentStores { description, error in
            if let error = error {
                print("failed to load data: \(error.localizedDescription)")
            }
        }
    }
}
