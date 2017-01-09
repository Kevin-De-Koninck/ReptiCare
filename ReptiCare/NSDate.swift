//
//  NSDate.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 16/09/16.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import Foundation

// SWIFT 3
//extension DateFormatter {
//    convenience init(dateStyle: DateFormatter.Style) {
//        self.init()
//        self.dateStyle = dateStyle
//    }
//}
//
//extension Date {
//    struct Formatter {
//        static let shortDate = DateFormatter(dateStyle: .short)
//    }
//    var shortDate: String {
//        return Formatter.shortDate.string(from: self)
//    }
//}
//

extension DateFormatter {
    convenience init(dateStyle: DateFormatter.Style) {
        self.init()
        self.dateStyle = dateStyle
    }
}

extension NSDate {
    struct Formatter {
        static let shortDate = DateFormatter(dateStyle: .short)
        static let fullDate = DateFormatter(dateStyle: .full)
        static let longDate = DateFormatter(dateStyle: .long)
        static let mediumDate = DateFormatter(dateStyle: .medium)
    }
    
    var shortDate: String { // 2/28/16
        return Formatter.shortDate.string(from: self as Date)
    }
    
    var fullDate: String { // Wednesday, December 28, 2016
        return Formatter.fullDate.string(from: self as Date)
    }
    
    var longDate: String { // December 28, 2016
        return Formatter.longDate.string(from: self as Date)
    }
    
    var mediumDate: String { // Dec 28, 2016
        return Formatter.mediumDate.string(from: self as Date)
    }
    
}
