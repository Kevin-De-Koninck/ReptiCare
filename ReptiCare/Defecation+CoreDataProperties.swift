//
//  Defecation+CoreDataProperties.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 24/09/2016.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import Foundation
import CoreData 

extension Defecation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Defecation> {
        return NSFetchRequest<Defecation>(entityName: "Defecation");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var kindOfDefecation_: NSNumber?
    @NSManaged public var note: String?
    @NSManaged public var uniqueID: NSNumber?
    @NSManaged public var reptile: Reptile?

}
