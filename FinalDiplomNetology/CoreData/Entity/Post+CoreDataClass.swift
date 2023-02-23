//
//  Post+CoreDataClass.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 22.02.2023.
//
//

import Foundation
import CoreData

@objc(Post)
public class Post: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.shared.entityForName("Post"), insertInto: CoreDataManager.shared.context)
    }
}
