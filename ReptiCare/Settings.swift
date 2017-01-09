//
//  Settings.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 05/09/16.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import Foundation
import CoreData


public class Settings: NSManagedObject {

// Convert ENUM data
    var weightUnit: WeightUnit {
        get{
            if let item = self.weightUnit_ {
                return WeightUnit(rawValue: item.intValue)!
            } else {
                return WeightUnit.gram
            }
        }
        set{
            self.weightUnit_ = newValue.rawValue as NSNumber?
        }
    }
}
