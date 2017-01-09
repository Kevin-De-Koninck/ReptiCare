//
//  FeedingItem.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 05/09/16.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import Foundation
import CoreData


public class FeedingItem: NSManagedObject {

// Convert ENUM data
    var foodItem: FoodItem {
        get{
            if let item = self.foodItem_ {
                return FoodItem(rawValue: item.intValue)!
            } else {
                return FoodItem.custom
            }
        }
        set{
            self.foodItem_ = newValue.rawValue as NSNumber?
        }
    }

    var foodSize: FoodSize {
        get{
            if let item = self.foodSize_ {
                return FoodSize(rawValue: item.intValue)!
            } else {
                return FoodSize.custom
            }
        }
        set{
            self.foodSize_ = newValue.rawValue as NSNumber?
        }
    }

}
