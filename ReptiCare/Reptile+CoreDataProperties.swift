//
//  Reptile+CoreDataProperties.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 24/09/2016.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import Foundation
import CoreData 

extension Reptile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reptile> {
        return NSFetchRequest<Reptile>(entityName: "Reptile");
    }

    @NSManaged public var breed: String?
    @NSManaged public var dateOfBirth: NSDate?
    @NSManaged public var feedingPeriodInDays: NSNumber?
    @NSManaged public var gender_: NSNumber?
    @NSManaged public var idealTemperatureAtDay: String?
    @NSManaged public var idealTemperatureAtNight: String?
    @NSManaged public var image: NSData?
    @NSManaged public var imageHeader: NSData?
    @NSManaged public var morph: String?
    @NSManaged public var name: String?
    @NSManaged public var reminderTime: NSDate?
    @NSManaged public var uniqueID: NSNumber?
    @NSManaged public var defecations: NSSet?
    @NSManaged public var feedings: NSSet?
    @NSManaged public var lengths: NSSet?
    @NSManaged public var others: NSSet?
    @NSManaged public var sheddings: NSSet?
    @NSManaged public var weights: NSSet?

}

// MARK: Generated accessors for defecations
extension Reptile {

    @objc(addDefecationsObject:)
    @NSManaged private func addToDefecations(_ value: Defecation)

    @objc(removeDefecationsObject:)
    @NSManaged private func removeFromDefecations(_ value: Defecation)

    @objc(addDefecations:)
    @NSManaged public func addToDefecations(_ values: NSSet)

    @objc(removeDefecations:)
    @NSManaged public func removeFromDefecations(_ values: NSSet)

}

// MARK: Generated accessors for feedings
extension Reptile {

    @objc(addFeedingsObject:)
    @NSManaged public func addToFeedings(_ value: Feeding)

    @objc(removeFeedingsObject:)
    @NSManaged public func removeFromFeedings(_ value: Feeding)

    @objc(addFeedings:)
    @NSManaged public func addToFeedings(_ values: NSSet)

    @objc(removeFeedings:)
    @NSManaged public func removeFromFeedings(_ values: NSSet)

}

// MARK: Generated accessors for lengths
extension Reptile {

    @objc(addLengthsObject:)
    @NSManaged public func addToLengths(_ value: Length)

    @objc(removeLengthsObject:)
    @NSManaged public func removeFromLengths(_ value: Length)

    @objc(addLengths:)
    @NSManaged public func addToLengths(_ values: NSSet)

    @objc(removeLengths:)
    @NSManaged public func removeFromLengths(_ values: NSSet)

}

// MARK: Generated accessors for others
extension Reptile {

    @objc(addOthersObject:)
    @NSManaged public func addToOthers(_ value: Other)

    @objc(removeOthersObject:)
    @NSManaged public func removeFromOthers(_ value: Other)

    @objc(addOthers:)
    @NSManaged public func addToOthers(_ values: NSSet)

    @objc(removeOthers:)
    @NSManaged public func removeFromOthers(_ values: NSSet)

}

// MARK: Generated accessors for sheddings
extension Reptile {

    @objc(addSheddingsObject:)
    @NSManaged public func addToSheddings(_ value: Shedding)

    @objc(removeSheddingsObject:)
    @NSManaged public func removeFromSheddings(_ value: Shedding)

    @objc(addSheddings:)
    @NSManaged public func addToSheddings(_ values: NSSet)

    @objc(removeSheddings:)
    @NSManaged public func removeFromSheddings(_ values: NSSet)

}

// MARK: Generated accessors for weights
extension Reptile {

    @objc(addWeightsObject:)
    @NSManaged public func addToWeights(_ value: Weight)

    @objc(removeWeightsObject:)
    @NSManaged public func removeFromWeights(_ value: Weight)

    @objc(addWeights:)
    @NSManaged public func addToWeights(_ values: NSSet)

    @objc(removeWeights:)
    @NSManaged public func removeFromWeights(_ values: NSSet)

}
