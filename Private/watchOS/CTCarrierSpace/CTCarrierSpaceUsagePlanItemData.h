//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 11207.0.0.0.0
//
#ifndef CTCarrierSpaceUsagePlanItemData_h
#define CTCarrierSpaceUsagePlanItemData_h
@import Foundation;

#include "NSSecureCoding-Protocol.h"

@class NSString;

@interface CTCarrierSpaceUsagePlanItemData : NSObject<NSSecureCoding>

@property (nonatomic) long long units;
@property (retain, nonatomic) NSString *capacity;
@property (retain, nonatomic) NSString *maxDataBeforeThrottling;
@property (retain, nonatomic) NSString *thisDeviceDataUsed;
@property (retain, nonatomic) NSString *sharedDataUsed;
@property (retain, nonatomic) NSString *sharedPlanIdentifier;

/* class methods */
+ (BOOL)supportsSecureCoding;

/* instance methods */
- (id)init;
- (id)description;
- (BOOL)isEqual:(id)equal;
- (void)encodeWithCoder:(id)coder;
- (id)initWithCoder:(id)coder;
@end

#endif /* CTCarrierSpaceUsagePlanItemData_h */