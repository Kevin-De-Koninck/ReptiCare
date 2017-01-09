//
//  FeedingItem+CoreDataProperties.h
//  ReptiCare
//
//  Created by Kevin De Koninck on 24/09/2016.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

#import ".FeedingItem+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface FeedingItem (CoreDataProperties)

+ (NSFetchRequest<FeedingItem *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *customFoodItem;
@property (nullable, nonatomic, copy) NSString *customFoodSize;
@property (nullable, nonatomic, copy) NSNumber *foodItem_;
@property (nullable, nonatomic, copy) NSNumber *foodSize_;
@property (nullable, nonatomic, copy) NSNumber *live;
@property (nullable, nonatomic, copy) NSNumber *uniqueID;
@property (nullable, nonatomic, retain) NSSet<Feeding *> *feedings;

@end

@interface FeedingItem (CoreDataGeneratedAccessors)

- (void)addFeedingsObject:(Feeding *)value;
- (void)removeFeedingsObject:(Feeding *)value;
- (void)addFeedings:(NSSet<Feeding *> *)values;
- (void)removeFeedings:(NSSet<Feeding *> *)values;

@end

NS_ASSUME_NONNULL_END
