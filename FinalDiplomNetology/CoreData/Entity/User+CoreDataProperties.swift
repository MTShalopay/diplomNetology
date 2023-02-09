//
//  User+CoreDataProperties.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 09.02.2023.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var uuID: String?
    @NSManaged public var numberPhone: String?
    @NSManaged public var password: Int16
    @NSManaged public var firstName: String?
    @NSManaged public var secondName: String?
    @NSManaged public var dayBirth: String?
    @NSManaged public var city: String?
    @NSManaged public var profession: String?

}

extension User : Identifiable {

}
