//
//  SwiftUI_Day_57App.swift
//  SwiftUI Day 57
//
//  Created by Deye Lei on 11/16/22.
//

import SwiftUI

@main
struct SwiftUI_Day_57App: App {
    @StateObject var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
