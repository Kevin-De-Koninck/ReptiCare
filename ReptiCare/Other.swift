//
//  Other.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 05/09/16.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import Foundation
import CoreData
import UIKit


public class Other: NSManagedObject {

// Set and Get images
    func setImg(_ img: UIImage?) {
        if let image_ = img{
            let data = UIImagePNGRepresentation(image_)
            self.image = data as NSData?
        } else {
            self.image = nil
        }
    }
    
    func getImg() -> UIImage? {
        if let data_ = self.image {
            return UIImage(data: data_ as Data)!
        } else {
            return nil
        }
    }
    
}
