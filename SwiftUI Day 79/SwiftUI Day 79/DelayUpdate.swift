//
//  DelayUpdate.swift
//  SwiftUI Day 79
//
//  Created by Deye Lei on 12/29/22.
//

import Foundation

@MainActor class DelayedUpdater: ObservableObject {
    var value:Int = 0{
        willSet{
            objectWillChange.send()
        }
    }

    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}
