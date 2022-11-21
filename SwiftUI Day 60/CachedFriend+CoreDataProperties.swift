//
//  CachedFriend+CoreDataProperties.swift
//  SwiftUI Day 60
//
//  Created by Deye Lei on 11/21/22.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var friendOf: CachedUser?

    var wrappedName: String{
        name ?? "???"
    }
}

extension CachedFriend : Identifiable {

}
