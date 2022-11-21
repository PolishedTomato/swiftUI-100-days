//
//  Tag+CoreDataProperties.swift
//  SwiftUI Day 60
//
//  Created by Deye Lei on 11/21/22.
//
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var tag: String?
    @NSManaged public var tagOf: CachedUser?

}

extension Tag : Identifiable {

}
