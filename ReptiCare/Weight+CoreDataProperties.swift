//
//  Weight+CoreDataProperties.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 24/09/2016.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import Foundation
import CoreData 

extension Weight {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weight> {
        return NSFetchRequest<Weight>(entityName: "Weight");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var uniqueID: NSNumber?
    @NSManaged public var weight: NSNumber?
    @NSManaged public var reptile: Reptile?

}
