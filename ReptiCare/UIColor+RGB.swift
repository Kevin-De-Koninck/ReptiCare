//
//  UIColor+RGB.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 16/09/16.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
    
    func lighter(_ percentage:CGFloat=30.0) -> UIColor? {
        return self.adjust( abs(percentage) )
    }
    
    func darker(_ percentage:CGFloat=30.0) -> UIColor? {
        return self.adjust( -1 * abs(percentage) )
    }
    
    func adjust(_ percentage:CGFloat=30.0) -> UIColor? {
        var r:CGFloat=0, g:CGFloat=0, b:CGFloat=0, a:CGFloat=0;
        if(self.getRed(&r, green: &g, blue: &b, alpha: &a)){
            return UIColor(red: min(r + percentage/100, 1.0),
                           green: min(g + percentage/100, 1.0),
                           blue: min(b + percentage/100, 1.0),
                           alpha: a)
        }else{
            return nil
        }
    }
}
