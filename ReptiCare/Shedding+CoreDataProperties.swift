//
//  Shedding+CoreDataProperties.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 24/09/2016.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import Foundation
import CoreData 

extension Shedding {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Shedding> {
        return NSFetchRequest<Shedding>(entityName: "Shedding");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var exelentShedding: NSNumber?
    @NSManaged public var note: String?
    @NSManaged public var uniqueID: NSNumber?
    @NSManaged public var reptile: Reptile?

}
