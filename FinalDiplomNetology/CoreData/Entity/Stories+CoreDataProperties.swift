//
//  Stories+CoreDataProperties.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 20.02.2023.
//
//

import Foundation
import CoreData


extension Stories {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stories> {
        return NSFetchRequest<Stories>(entityName: "Stories")
    }

    @NSManaged public var date: Date?
    @NSManaged public var image: Data?
    @NSManaged public var user: User?

}

extension Stories : Identifiable {

}
