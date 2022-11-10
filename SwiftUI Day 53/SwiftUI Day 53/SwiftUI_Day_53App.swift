//
//  SwiftUI_Day_53App.swift
//  SwiftUI Day 53
//
//  Created by Deye Lei on 11/10/22.
//

import SwiftUI

//hackingwithswift explain managaedObjectContext is like "live version" of your data
//the job of the view context is to let us work with all our data in memory, which is much faster than constantly reading and writing data to disk
@main
struct SwiftUI_Day_53App: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
