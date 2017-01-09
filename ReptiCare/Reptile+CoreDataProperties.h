//
//  Reptile+CoreDataProperties.h
//  ReptiCare
//
//  Created by Kevin De Koninck on 24/09/2016.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

#import ".Reptile+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Reptile (CoreDataProperties)

+ (NSFetchRequest<Reptile *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *breed;
@property (nullable, nonatomic, copy) NSDate *dateOfBirth;
@property (nullable, nonatomic, copy) NSNumber *feedingPeriodInDays;
@property (nullable, nonatomic, copy) NSNumber *gender_;
@property (nullable, nonatomic, copy) NSString *idealTemperatureAtDay;
@property (nullable, nonatomic, copy) NSString *idealTemperatureAtNight;
@property (nullable, nonatomic, retain) NSData *image;
@property (nullable, nonatomic, retain) NSData *imageHeader;
@property (nullable, nonatomic, copy) NSString *morph;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSDate *reminderTime;
@property (nullable, nonatomic, copy) NSNumber *uniqueID;
@property (nullable, nonatomic, retain) NSSet<Defecation *> *defecations;
@property (nullable, nonatomic, retain) NSSet<Feeding *> *feedings;
@property (nullable, nonatomic, retain) NSSet<Length *> *lengths;
@property (nullable, nonatomic, retain) NSSet<Other *> *others;
@property (nullable, nonatomic, retain) NSSet<Shedding *> *sheddings;
@property (nullable, nonatomic, retain) NSSet<Weight *> *weights;

@end

@interface Reptile (CoreDataGeneratedAccessors)

- (void)addDefecationsObject:(Defecation *)value;
- (void)removeDefecationsObject:(Defecation *)value;
- (void)addDefecations:(NSSet<Defecation *> *)values;
- (void)removeDefecations:(NSSet<Defecation *> *)values;

- (void)addFeedingsObject:(Feeding *)value;
- (void)removeFeedingsObject:(Feeding *)value;
- (void)addFeedings:(NSSet<Feeding *> *)values;
- (void)removeFeedings:(NSSet<Feeding *> *)values;

- (void)addLengthsObject:(Length *)value;
- (void)removeLengthsObject:(Length *)value;
- (void)addLengths:(NSSet<Length *> *)values;
- (void)removeLengths:(NSSet<Length *> *)values;

- (void)addOthersObject:(Other *)value;
- (void)removeOthersObject:(Other *)value;
- (void)addOthers:(NSSet<Other *> *)values;
- (void)removeOthers:(NSSet<Other *> *)values;

- (void)addSheddingsObject:(Shedding *)value;
- (void)removeSheddingsObject:(Shedding *)value;
- (void)addSheddings:(NSSet<Shedding *> *)values;
- (void)removeSheddings:(NSSet<Shedding *> *)values;

- (void)addWeightsObject:(Weight *)value;
- (void)removeWeightsObject:(Weight *)value;
- (void)addWeights:(NSSet<Weight *> *)values;
- (void)removeWeights:(NSSet<Weight *> *)values;

@end

NS_ASSUME_NONNULL_END
