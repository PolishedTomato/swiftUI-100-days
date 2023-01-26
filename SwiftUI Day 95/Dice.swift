//
//  Dice.swift
//  SwiftUI Day 95
//
//  Created by Deye Lei on 1/26/23.
//

import Foundation
import SwiftUI

struct Dice: Identifiable{
    var val: Int
    var id = UUID()
    var color: Color
    
    
    
    init(val: Int, color: Color){
        self.val = val
        self.color = color
    }
    
}
