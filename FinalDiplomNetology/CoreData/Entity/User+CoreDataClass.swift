//
//  User+CoreDataClass.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 22.02.2023.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.shared.entityForName("User"), insertInto: CoreDataManager.shared.context)
    }
}
