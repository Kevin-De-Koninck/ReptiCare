//
//  Settings+CoreDataProperties.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 24/09/2016.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import Foundation
import CoreData


extension Settings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Settings> {
        return NSFetchRequest<Settings>(entityName: "Settings");
    }

    @NSManaged public var disablePushNotifications: NSNumber?
    @NSManaged public var disableSounds: NSNumber?
    @NSManaged public var language: String?
    @NSManaged public var uniqueID: NSNumber?
    @NSManaged public var weightUnit_: NSNumber?

}
