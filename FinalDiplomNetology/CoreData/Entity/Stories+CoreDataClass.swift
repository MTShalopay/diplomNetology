//
//  Stories+CoreDataClass.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 20.02.2023.
//
//

import Foundation
import CoreData

@objc(Stories)
public class Stories: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.shared.entityForName("Stories"), insertInto: CoreDataManager.shared.context)
    }
}
