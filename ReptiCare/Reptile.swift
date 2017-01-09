//
//  Reptile.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 05/09/16.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import Foundation
import CoreData
import UIKit


public class Reptile: NSManagedObject {

// Convert ENUM data
    var gender: Gender {
        get{
            if let item = self.gender_ {
                return Gender(rawValue: item.intValue)!
            } else {
                return Gender.male
            }
        }
        set{
            self.gender_ = newValue.rawValue as NSNumber?
        }
    }
    
// Set and Get images
    func setImg(_ img: UIImage) {
        let data = UIImagePNGRepresentation(img)
        self.image = data as NSData?
    }
    
    func getImg() -> UIImage {
        if let data_ = self.image, let img: UIImage = UIImage(data: data_ as Data) {
            return img
        } else {
            return UIImage(named: "default_image")!
        }
    }
    
    func setImgHeader(_ img: UIImage) {
        let data = UIImagePNGRepresentation(img)
        self.imageHeader = data as NSData?
    }
    
    func getImgHeader() -> UIImage {
        if let data_ = self.imageHeader, let img: UIImage = UIImage(data: data_ as Data) {
            return img
        } else {
            return UIImage(named: "default_image")!
        }
    }

}
