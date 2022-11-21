//
//  SwiftUI_Day_60App.swift
//  SwiftUI Day 60
//
//  Created by Deye Lei on 11/18/22.
//

import SwiftUI

@main
struct SwiftUI_Day_60App: App {
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                
            
        }
    }
}
