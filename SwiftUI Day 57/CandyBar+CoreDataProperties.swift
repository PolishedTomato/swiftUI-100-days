//
//  CandyBar+CoreDataProperties.swift
//  SwiftUI Day 57
//
//  Created by Deye Lei on 11/16/22.
//
//

import Foundation
import CoreData


extension CandyBar {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CandyBar> {
        return NSFetchRequest<CandyBar>(entityName: "CandyBar")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: County?

    var wrappedName: String{
        name ?? "Unkown"
    }
}

extension CandyBar : Identifiable {

}
