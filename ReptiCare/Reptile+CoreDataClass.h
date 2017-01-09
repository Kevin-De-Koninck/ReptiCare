//
//  Reptile+CoreDataClass.h
//  ReptiCare
//
//  Created by Kevin De Koninck on 24/09/2016.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Defecation, Feeding, Length, Other, Shedding, Weight;

NS_ASSUME_NONNULL_BEGIN

@interface Reptile : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "Reptile+CoreDataProperties.h"
