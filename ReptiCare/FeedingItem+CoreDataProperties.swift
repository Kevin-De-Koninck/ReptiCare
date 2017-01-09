//
//  FeedingItem+CoreDataProperties.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 24/09/2016.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import Foundation
import CoreData 

extension FeedingItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FeedingItem> {
        return NSFetchRequest<FeedingItem>(entityName: "FeedingItem");
    }

    @NSManaged public var customFoodItem: String?
    @NSManaged public var customFoodSize: String?
    @NSManaged public var foodItem_: NSNumber?
    @NSManaged public var foodSize_: NSNumber?
    @NSManaged public var live: NSNumber?
    @NSManaged public var uniqueID: NSNumber?
    @NSManaged public var feedings: NSSet?

}

// MARK: Generated accessors for feedings
extension FeedingItem {

    @objc(addFeedingsObject:)
    @NSManaged public func addToFeedings(_ value: Feeding)

    @objc(removeFeedingsObject:)
    @NSManaged public func removeFromFeedings(_ value: Feeding)

    @objc(addFeedings:)
    @NSManaged public func addToFeedings(_ values: NSSet)

    @objc(removeFeedings:)
    @NSManaged public func removeFromFeedings(_ values: NSSet)

}
