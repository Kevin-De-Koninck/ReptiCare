//
//  Defecation+CoreDataProperties.h
//  ReptiCare
//
//  Created by Kevin De Koninck on 24/09/2016.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

#import ".Defecation+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Defecation (CoreDataProperties)

+ (NSFetchRequest<Defecation *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSNumber *kindOfDefecation_;
@property (nullable, nonatomic, copy) NSString *note;
@property (nullable, nonatomic, copy) NSNumber *uniqueID;
@property (nullable, nonatomic, retain) Reptile *reptile;

@end

NS_ASSUME_NONNULL_END
