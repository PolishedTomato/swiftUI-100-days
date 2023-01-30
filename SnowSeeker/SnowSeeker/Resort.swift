//
//  Resort.swift
//  SnowSeeker
//
//  Created by Deye Lei on 1/30/23.
//

import Foundation

struct Resort: Identifiable, Codable{
    var id:String
    var name:String
    var country: String
    var description: String
    var imageCredit: String
    var price: Int
    var size: Int
    var snowDepth: Int
    var elevation: Int
    var runs: Int
    var facilities: [String]
}

extension Resort{
    /*
    static let example = (Bundle.main.decode("resorts.json") as [Resort])[0]
    */
    //below is much clearer and easy to use.
    static let allResorts:[Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
}
