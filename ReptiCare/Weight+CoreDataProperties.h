//
//  Weight+CoreDataProperties.h
//  ReptiCare
//
//  Created by Kevin De Koninck on 24/09/2016.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

#import ".Weight+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Weight (CoreDataProperties)

+ (NSFetchRequest<Weight *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSNumber *uniqueID;
@property (nullable, nonatomic, copy) NSNumber *weight;
@property (nullable, nonatomic, retain) Reptile *reptile;

@end

NS_ASSUME_NONNULL_END
