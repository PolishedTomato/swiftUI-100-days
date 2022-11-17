//
//  County+CoreDataProperties.swift
//  SwiftUI Day 57
//
//  Created by Deye Lei on 11/16/22.
//
//

import Foundation
import CoreData


extension County {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<County> {
        return NSFetchRequest<County>(entityName: "County")
    }

    @NSManaged public var name: String?
    @NSManaged public var candy: NSSet?
    
    public var candyArray: [CandyBar] {
        let set = candy as? Set<CandyBar> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }

    var wrappedName: String{
        name ?? "Unknown"
    }
}

// MARK: Generated accessors for candy
extension County {

    @objc(addCandyObject:)
    @NSManaged public func addToCandy(_ value: CandyBar)

    @objc(removeCandyObject:)
    @NSManaged public func removeFromCandy(_ value: CandyBar)

    @objc(addCandy:)
    @NSManaged public func addToCandy(_ values: NSSet)

    @objc(removeCandy:)
    @NSManaged public func removeFromCandy(_ values: NSSet)

}

extension County : Identifiable {

}
