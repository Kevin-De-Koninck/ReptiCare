//
//  Settings+CoreDataProperties.h
//  ReptiCare
//
//  Created by Kevin De Koninck on 24/09/2016.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

#import ".Settings+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Settings (CoreDataProperties)

+ (NSFetchRequest<Settings *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *disablePushNotifications;
@property (nullable, nonatomic, copy) NSNumber *disableSounds;
@property (nullable, nonatomic, copy) NSString *language;
@property (nullable, nonatomic, copy) NSNumber *uniqueID;
@property (nullable, nonatomic, copy) NSNumber *weightUnit_;

@end

NS_ASSUME_NONNULL_END
