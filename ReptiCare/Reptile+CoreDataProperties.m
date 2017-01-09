//
//  Reptile+CoreDataProperties.m
//  ReptiCare
//
//  Created by Kevin De Koninck on 24/09/2016.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

#import "Reptile+CoreDataProperties.h"

@implementation Reptile (CoreDataProperties)

+ (NSFetchRequest<Reptile *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Reptile"];
}

@dynamic breed;
@dynamic dateOfBirth;
@dynamic feedingPeriodInDays;
@dynamic gender_;
@dynamic idealTemperatureAtDay;
@dynamic idealTemperatureAtNight;
@dynamic image;
@dynamic imageHeader;
@dynamic morph;
@dynamic name;
@dynamic reminderTime;
@dynamic uniqueID;
@dynamic defecations;
@dynamic feedings;
@dynamic lengths;
@dynamic others;
@dynamic sheddings;
@dynamic weights;

@end
