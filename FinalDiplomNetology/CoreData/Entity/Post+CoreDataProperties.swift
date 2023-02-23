//
//  Post+CoreDataProperties.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 22.02.2023.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var commit: Int16
    @NSManaged public var date: Date?
    @NSManaged public var favorite: Bool
    @NSManaged public var image: Data?
    @NSManaged public var like: Int16
    @NSManaged public var text: String?
    @NSManaged public var user: User?

}

extension Post : Identifiable {

}
