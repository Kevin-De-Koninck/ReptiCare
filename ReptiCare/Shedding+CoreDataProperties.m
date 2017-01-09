//
//  Shedding+CoreDataProperties.m
//  ReptiCare
//
//  Created by Kevin De Koninck on 24/09/2016.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

#import "Shedding+CoreDataProperties.h"

@implementation Shedding (CoreDataProperties)

+ (NSFetchRequest<Shedding *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Shedding"];
}

@dynamic date;
@dynamic exelentShedding;
@dynamic note;
@dynamic uniqueID;
@dynamic reptile;

@end
