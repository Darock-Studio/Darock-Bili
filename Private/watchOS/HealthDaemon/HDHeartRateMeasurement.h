//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 4146.2.12.2.2
//
#ifndef HDHeartRateMeasurement_h
#define HDHeartRateMeasurement_h
@import Foundation;

#include "HDHealthServiceCharacteristic.h"
#include "HDDatumRendering-Protocol.h"

@class NSArray, NSDate;

@interface HDHeartRateMeasurement : HDHealthServiceCharacteristic<HDDatumRendering>

@property (readonly, nonatomic) NSDate *updateTime;
@property (nonatomic) long long heartRateValue;
@property (nonatomic) BOOL hasEnergyExpended;
@property (nonatomic) long long energyExpended;
@property (nonatomic) BOOL hasSensorContact;
@property (nonatomic) BOOL sensorContact;
@property (retain, nonatomic) NSArray *rrIntervals;
@property (readonly, nonatomic) unsigned long long derivedContactStatus;

/* class methods */
+ (id)uuid;
+ (id)_buildWithBinaryValue:(id)value error:(id *)error;

/* instance methods */
- (id)generateDatums:(id)datums;
- (id)description;
@end

#endif /* HDHeartRateMeasurement_h */