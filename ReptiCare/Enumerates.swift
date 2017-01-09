//
//  Enumerates.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 05/09/16.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import Foundation

enum WeightUnit: Int {
    case gram
    case kilogram
    case pounds
}

enum Gender: Int {
    case male
    case female
    case unknown
}

enum DefecationKind: Int {
    case poop
    case urine
}

enum FoodItem: Int {
    case mouse
    case rat
    case chicken
    case hamster
    case gerbil
    case rabbit
    case custom
}

enum FoodSize: Int {
    case pinky
    case jumbo
    case adult
    case weaned
    case hopper
    case fuzzy
    case custom
}

enum ReptileMenuItems: Int {
    case profile
    case feedings
    case sheddings
    case defecations
    case length
    case weight
    case notes
    case statistics
    case share
}
