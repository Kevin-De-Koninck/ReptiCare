//
//  Length+CoreDataProperties.m
//  ReptiCare
//
//  Created by Kevin De Koninck on 24/09/2016.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

#import "Length+CoreDataProperties.h"

@implementation Length (CoreDataProperties)

+ (NSFetchRequest<Length *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Length"];
}

@dynamic date;
@dynamic length;
@dynamic uniqueID;
@dynamic reptile;

@end
