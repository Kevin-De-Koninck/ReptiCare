//
//  Settings+CoreDataProperties.m
//  ReptiCare
//
//  Created by Kevin De Koninck on 24/09/2016.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

#import "Settings+CoreDataProperties.h"

@implementation Settings (CoreDataProperties)

+ (NSFetchRequest<Settings *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Settings"];
}

@dynamic disablePushNotifications;
@dynamic disableSounds;
@dynamic language;
@dynamic uniqueID;
@dynamic weightUnit_;

@end
