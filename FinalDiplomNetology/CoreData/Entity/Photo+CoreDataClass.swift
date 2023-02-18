//
//  Photo+CoreDataClass.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 17.02.2023.
//
//

import Foundation
import CoreData

@objc(Photo)
public class Photo: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.shared.entityForName("Photo"), insertInto: CoreDataManager.shared.context)
    }
}
