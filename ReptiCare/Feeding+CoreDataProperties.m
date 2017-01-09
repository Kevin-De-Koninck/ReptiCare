//
//  Feeding+CoreDataProperties.m
//  ReptiCare
//
//  Created by Kevin De Koninck on 24/09/2016.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

#import "Feeding+CoreDataProperties.h"

@implementation Feeding (CoreDataProperties)

+ (NSFetchRequest<Feeding *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Feeding"];
}

@dynamic date;
@dynamic note;
@dynamic refused;
@dynamic uniqueID;
@dynamic feedingItems;
@dynamic reptile;

@end
