//
//  File.swift
//  cupCakeCorner
//
//  Created by Deye Lei on 11/8/22.
//

import Foundation

//challenge 3 create another class to hold Order class(change it to struct)
//and I use this class for stateObject in the project instead(it works!)
class OrderWrapper: ObservableObject, Codable{
    @Published var order = Order_Copy()
    enum CodingKeys: CodingKey{
        case order
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(order, forKey: .order)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        order = try container.decode(Order_Copy.self, forKey: .order)
    }
    
    init(){
        
    }
}


struct Order_Copy: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet{
            if specialRequestEnabled == false{
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zipCode = ""
    
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

class Order: ObservableObject, Codable {
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
    
    enum codingKeys: CodingKey{
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zipCode
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: codingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zipCode, forKey: .zipCode)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: codingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zipCode = try container.decode(String.self, forKey: .zipCode)
    }
    
    init(){
        
    }
}
