//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 624.0.100.0.0
//
#ifndef PLDetectionTrait_h
#define PLDetectionTrait_h
@import Foundation;

#include "PLManagedObject.h"
#include "PLDetectedFace.h"

@interface PLDetectionTrait : PLManagedObject

@property (@dynamic, nonatomic) short type;
@property (@dynamic, nonatomic) short value;
@property (@dynamic, nonatomic) double score;
@property (@dynamic, nonatomic) double startTime;
@property (@dynamic, nonatomic) double duration;
@property (retain, @dynamic, nonatomic) PLDetectedFace *detection;

/* class methods */
+ (id)entityName;
+ (id)insertIntoManagedObjectContext:(id)context type:(short)type value:(short)value score:(double)score startTime:(double)time duration:(double)duration;
+ (id)fetchDetectionTraitByFaceUUIDWithFaceUUIDs:(id)uuids library:(id)library error:(id *)error;
+ (BOOL)isPetDetectionType:(short)type;

/* instance methods */
- (void)willSave;
- (void)_touchPersonForPersistenceIfNeeded;
- (id)debugLogDescription;
@end

#endif /* PLDetectionTrait_h */