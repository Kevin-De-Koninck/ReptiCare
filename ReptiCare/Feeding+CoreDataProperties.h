//
//  Feeding+CoreDataProperties.h
//  ReptiCare
//
//  Created by Kevin De Koninck on 24/09/2016.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

#import ".Feeding+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Feeding (CoreDataProperties)

+ (NSFetchRequest<Feeding *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSString *note;
@property (nullable, nonatomic, copy) NSNumber *refused;
@property (nullable, nonatomic, copy) NSNumber *uniqueID;
@property (nullable, nonatomic, retain) NSSet<FeedingItem *> *feedingItems;
@property (nullable, nonatomic, retain) Reptile *reptile;

@end

@interface Feeding (CoreDataGeneratedAccessors)

- (void)addFeedingItemsObject:(FeedingItem *)value;
- (void)removeFeedingItemsObject:(FeedingItem *)value;
- (void)addFeedingItems:(NSSet<FeedingItem *> *)values;
- (void)removeFeedingItems:(NSSet<FeedingItem *> *)values;

@end

NS_ASSUME_NONNULL_END
