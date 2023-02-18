//
//  Subscribe+CoreDataClass.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 17.02.2023.
//
//

import Foundation
import CoreData

@objc(Subscribe)
public class Subscribe: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.shared.entityForName("Subscribe"), insertInto: CoreDataManager.shared.context)
    }
}
