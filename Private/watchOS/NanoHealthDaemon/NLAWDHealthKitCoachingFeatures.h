//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1880.5.0.0.0
//
#ifndef NLAWDHealthKitCoachingFeatures_h
#define NLAWDHealthKitCoachingFeatures_h
@import Foundation;

#include "PBCodable.h"
#include "NSCopying-Protocol.h"

@interface NLAWDHealthKitCoachingFeatures : PBCodable<NSCopying> {
  /* instance variables */
  struct { unsigned int x :1 activeCalories; unsigned int x :1 automotive; unsigned int x :1 briskMinutes; unsigned int x :1 cycling; unsigned int x :1 duration; unsigned int x :1 heartRate; unsigned int x :1 other; unsigned int x :1 running; unsigned int x :1 unknown; unsigned int x :1 walking; unsigned int x :1 workout; } _has;
}

@property (nonatomic) BOOL hasWalking;
@property (nonatomic) unsigned int walking;
@property (nonatomic) BOOL hasAutomotive;
@property (nonatomic) unsigned int automotive;
@property (nonatomic) BOOL hasCycling;
@property (nonatomic) unsigned int cycling;
@property (nonatomic) BOOL hasRunning;
@property (nonatomic) unsigned int running;
@property (nonatomic) BOOL hasOther;
@property (nonatomic) unsigned int other;
@property (nonatomic) BOOL hasWorkout;
@property (nonatomic) unsigned int workout;
@property (nonatomic) BOOL hasHeartRate;
@property (nonatomic) unsigned int heartRate;
@property (nonatomic) BOOL hasActiveCalories;
@property (nonatomic) unsigned int activeCalories;
@property (nonatomic) BOOL hasBriskMinutes;
@property (nonatomic) unsigned int briskMinutes;
@property (nonatomic) BOOL hasDuration;
@property (nonatomic) unsigned int duration;
@property (nonatomic) BOOL hasUnknown;
@property (nonatomic) unsigned int unknown;

/* instance methods */
- (id)description;
- (id)dictionaryRepresentation;
- (BOOL)readFrom:(id)from;
- (void)writeTo:(id)to;
- (void)copyTo:(id)to;
- (id)copyWithZone:(struct _NSZone *)zone;
- (BOOL)isEqual:(id)equal;
- (unsigned long long)hash;
- (void)mergeFrom:(id)from;
@end

#endif /* NLAWDHealthKitCoachingFeatures_h */