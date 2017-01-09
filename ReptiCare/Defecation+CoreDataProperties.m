//
//  Defecation+CoreDataProperties.m
//  ReptiCare
//
//  Created by Kevin De Koninck on 24/09/2016.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

#import "Defecation+CoreDataProperties.h"

@implementation Defecation (CoreDataProperties)

+ (NSFetchRequest<Defecation *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Defecation"];
}

@dynamic date;
@dynamic kindOfDefecation_;
@dynamic note;
@dynamic uniqueID;
@dynamic reptile;

@end
