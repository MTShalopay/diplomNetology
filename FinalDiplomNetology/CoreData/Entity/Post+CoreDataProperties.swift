//
//  Post+CoreDataProperties.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 03.03.2023.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var date: Date?
    @NSManaged public var image: Data?
    @NSManaged public var text: String?
    @NSManaged public var user: User?
    @NSManaged public var userPostFavorite: User?

}

extension Post : Identifiable {

}
