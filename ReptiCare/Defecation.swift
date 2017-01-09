//
//  Defecation.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 05/09/16.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import Foundation
import CoreData


class Defecation: NSManagedObject {

// Convert ENUM data
    var kindOfDefecation: DefecationKind {
        get{
            if let item = self.kindOfDefecation_ {
                return DefecationKind(rawValue: item.intValue)!
            } else {
                return DefecationKind.poop
            }
        }
        set{
            self.kindOfDefecation_ = newValue.rawValue as NSNumber?
        }
    }
    
}
