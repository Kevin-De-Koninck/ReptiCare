//
//  Feeding+CoreDataProperties.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 24/09/2016.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import Foundation
import CoreData 

extension Feeding {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Feeding> {
        return NSFetchRequest<Feeding>(entityName: "Feeding");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var note: String?
    @NSManaged public var refused: NSNumber?
    @NSManaged public var uniqueID: NSNumber?
    @NSManaged public var feedingItems: NSSet?
    @NSManaged public var reptile: Reptile?

}

// MARK: Generated accessors for feedingItems
extension Feeding {

    @objc(addFeedingItemsObject:)
    @NSManaged public func addToFeedingItems(_ value: FeedingItem)

    @objc(removeFeedingItemsObject:)
    @NSManaged public func removeFromFeedingItems(_ value: FeedingItem)

    @objc(addFeedingItems:)
    @NSManaged public func addToFeedingItems(_ values: NSSet)

    @objc(removeFeedingItems:)
    @NSManaged public func removeFromFeedingItems(_ values: NSSet)

}
