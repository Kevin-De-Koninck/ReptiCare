//
//  FeedingItem+CoreDataProperties.m
//  ReptiCare
//
//  Created by Kevin De Koninck on 24/09/2016.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

#import "FeedingItem+CoreDataProperties.h"

@implementation FeedingItem (CoreDataProperties)

+ (NSFetchRequest<FeedingItem *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"FeedingItem"];
}

@dynamic customFoodItem;
@dynamic customFoodSize;
@dynamic foodItem_;
@dynamic foodSize_;
@dynamic live;
@dynamic uniqueID;
@dynamic feedings;

@end
