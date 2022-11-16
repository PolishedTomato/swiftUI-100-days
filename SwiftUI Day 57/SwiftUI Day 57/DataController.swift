//
//  DataController.swift
//  SwiftUI Day 57
//
//  Created by Deye Lei on 11/16/22.
//

import CoreData
import Foundation

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "CoreDataProject")
    
    init(){
        container.loadPersistentStores(completionHandler: {
            descritor, error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            
            //merge duplicate base on property
            self.container.viewContext.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
        })
        
    }
}
