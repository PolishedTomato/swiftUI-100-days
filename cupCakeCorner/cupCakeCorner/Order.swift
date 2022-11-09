//
//  File.swift
//  cupCakeCorner
//
//  Created by Deye Lei on 11/8/22.
//

import Foundation

class Order: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    @Published var type = 0
    @Published var quantity = 3

    @Published var specialRequestEnabled = false {
        didSet{
            if specialRequestEnabled == false{
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zipCode = ""
    
    var cost: Double{
        var cupCakeCost = Double(quantity) * 2
        cupCakeCost +=  Double(type) / 2
        
        if extraFrosting == true{
            cupCakeCost += Double(quantity) * 1
        }
        
        if addSprinkles {
            cupCakeCost += Double(quantity) / 2
        }
        return cupCakeCost
    }
}
