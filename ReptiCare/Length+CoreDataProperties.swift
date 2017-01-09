//
//  Length+CoreDataProperties.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 24/09/2016.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import Foundation
import CoreData 

extension Length {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Length> {
        return NSFetchRequest<Length>(entityName: "Length");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var length: NSNumber?
    @NSManaged public var uniqueID: NSNumber?
    @NSManaged public var reptile: Reptile?

}
