//
//  Other+CoreDataProperties.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 26/09/2016.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import Foundation
import CoreData

extension Other {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Other> {
        return NSFetchRequest<Other>(entityName: "Other");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var image: NSData?
    @NSManaged public var note: String?
    @NSManaged public var uniqueID: NSNumber?
    @NSManaged public var title: String?
    @NSManaged public var reptile: Reptile?

}
