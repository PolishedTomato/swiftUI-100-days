//
//  CachedUser+CoreDataProperties.swift
//  SwiftUI Day 60
//
//  Created by Deye Lei on 11/21/22.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var friendTo: NSSet?
    @NSManaged public var myTag: NSSet?

    var wrappedID: String{
        return id ?? "Unknown id"
    }
    
    var wrappedName: String{
        return name ?? "Unknown name"
    }
    
    var wrappedCompany:String{
        return company ?? "Unknown company"
    }
    
    var wrappedEmail: String{
        return email ?? "Unknown email"
    }
    
    var wrappedAddress:String{
        return address ?? "Unknown address"
    }
    
    var wrappedAbout: String{
        return about ?? "Unknown about"
    }
    
    var wrappedRegistered: Date{
        return registered ?? Date.now
    }
    
    var myFriends: [CachedFriend]{
        //optional type cast // try friend instead cachedFriend see what happen
        let data = friendTo as? Set<CachedFriend> ?? []
        return data.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    
    var myTags: [String]{
        let data = myTag as? Set<String> ?? []
        return data.sorted {
            $0 < $1
        }
    }
}

// MARK: Generated accessors for friendTo
extension CachedUser {

    @objc(addFriendToObject:)
    @NSManaged public func addToFriendTo(_ value: CachedFriend)

    @objc(removeFriendToObject:)
    @NSManaged public func removeFromFriendTo(_ value: CachedFriend)

    @objc(addFriendTo:)
    @NSManaged public func addToFriendTo(_ values: NSSet)

    @objc(removeFriendTo:)
    @NSManaged public func removeFromFriendTo(_ values: NSSet)

}

// MARK: Generated accessors for myTag
extension CachedUser {

    @objc(addMyTagObject:)
    @NSManaged public func addToMyTag(_ value: Tag)

    @objc(removeMyTagObject:)
    @NSManaged public func removeFromMyTag(_ value: Tag)

    @objc(addMyTag:)
    @NSManaged public func addToMyTag(_ values: NSSet)

    @objc(removeMyTag:)
    @NSManaged public func removeFromMyTag(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
