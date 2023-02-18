//
//  Follower+CoreDataClass.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 17.02.2023.
//
//

import Foundation
import CoreData

@objc(Follower)
public class Follower: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.shared.entityForName("Follower"), insertInto: CoreDataManager.shared.context)
    }
}
