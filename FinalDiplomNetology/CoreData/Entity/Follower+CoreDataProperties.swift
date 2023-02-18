//
//  Follower+CoreDataProperties.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 17.02.2023.
//
//

import Foundation
import CoreData


extension Follower {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Follower> {
        return NSFetchRequest<Follower>(entityName: "Follower")
    }

    @NSManaged public var state: Bool
    @NSManaged public var avatar: Data?
    @NSManaged public var city: String?
    @NSManaged public var dayBirth: String?
    @NSManaged public var firstName: String?
    @NSManaged public var numberPhone: String?
    @NSManaged public var profession: String?
    @NSManaged public var secondName: String?
    @NSManaged public var photos: NSSet?
    @NSManaged public var user: User?

}

// MARK: Generated accessors for photos
extension Follower {

    @objc(addPhotosObject:)
    @NSManaged public func addToPhotos(_ value: Photo)

    @objc(removePhotosObject:)
    @NSManaged public func removeFromPhotos(_ value: Photo)

    @objc(addPhotos:)
    @NSManaged public func addToPhotos(_ values: NSSet)

    @objc(removePhotos:)
    @NSManaged public func removeFromPhotos(_ values: NSSet)

}

extension Follower : Identifiable {

}
