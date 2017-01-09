//
//  Weight+CoreDataProperties.m
//  ReptiCare
//
//  Created by Kevin De Koninck on 24/09/2016.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

#import "Weight+CoreDataProperties.h"

@implementation Weight (CoreDataProperties)

+ (NSFetchRequest<Weight *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Weight"];
}

@dynamic date;
@dynamic uniqueID;
@dynamic weight;
@dynamic reptile;

@end
