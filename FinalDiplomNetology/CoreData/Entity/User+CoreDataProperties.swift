//
//  User+CoreDataProperties.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 22.02.2023.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var avatar: Data?
    @NSManaged public var city: String?
    @NSManaged public var dayBirth: String?
    @NSManaged public var firstName: String?
    @NSManaged public var numberPhone: String?
    @NSManaged public var password: String?
    @NSManaged public var profession: String?
    @NSManaged public var secondName: String?
    @NSManaged public var uuID: String?
    @NSManaged public var followers: NSSet?
    @NSManaged public var photos: NSSet?
    @NSManaged public var posts: NSSet?
    @NSManaged public var stories: Stories?
    @NSManaged public var subscriptions: NSSet?

}

// MARK: Generated accessors for followers
extension User {

    @objc(addFollowersObject:)
    @NSManaged public func addToFollowers(_ value: User)

    @objc(removeFollowersObject:)
    @NSManaged public func removeFromFollowers(_ value: User)

    @objc(addFollowers:)
    @NSManaged public func addToFollowers(_ values: NSSet)

    @objc(removeFollowers:)
    @NSManaged public func removeFromFollowers(_ values: NSSet)

}

// MARK: Generated accessors for photos
extension User {

    @objc(addPhotosObject:)
    @NSManaged public func addToPhotos(_ value: Photo)

    @objc(removePhotosObject:)
    @NSManaged public func removeFromPhotos(_ value: Photo)

    @objc(addPhotos:)
    @NSManaged public func addToPhotos(_ values: NSSet)

    @objc(removePhotos:)
    @NSManaged public func removeFromPhotos(_ values: NSSet)

}

// MARK: Generated accessors for posts
extension User {

    @objc(addPostsObject:)
    @NSManaged public func addToPosts(_ value: Post)

    @objc(removePostsObject:)
    @NSManaged public func removeFromPosts(_ value: Post)

    @objc(addPosts:)
    @NSManaged public func addToPosts(_ values: NSSet)

    @objc(removePosts:)
    @NSManaged public func removeFromPosts(_ values: NSSet)

}

// MARK: Generated accessors for subscriptions
extension User {

    @objc(addSubscriptionsObject:)
    @NSManaged public func addToSubscriptions(_ value: User)

    @objc(removeSubscriptionsObject:)
    @NSManaged public func removeFromSubscriptions(_ value: User)

    @objc(addSubscriptions:)
    @NSManaged public func addToSubscriptions(_ values: NSSet)

    @objc(removeSubscriptions:)
    @NSManaged public func removeFromSubscriptions(_ values: NSSet)

}

extension User : Identifiable {

}
