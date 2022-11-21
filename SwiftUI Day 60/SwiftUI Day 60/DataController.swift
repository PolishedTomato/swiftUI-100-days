//
//  DataController.swift
//  SwiftUI Day 60
//
//  Created by Deye Lei on 11/21/22.
//

import CoreData
import Foundation

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "MyData")
    
    init(){
        
        container.loadPersistentStores { description, error in
            if let error = error{
                print(error.localizedDescription)
                fatalError()
            }
        }
        container.viewContext.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
         
    }
    
    func deleteAll() {
          let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = CachedUser.fetchRequest()
          let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
          _ = try? container.viewContext.execute(batchDeleteRequest1)
    }
}
