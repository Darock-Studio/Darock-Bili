//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 104.0.1.0.0
//
#ifndef TADisplayOnCalculator_h
#define TADisplayOnCalculator_h
@import Foundation;

#include "NSSecureCoding-Protocol.h"

@class NSDate;

@interface TADisplayOnCalculator : NSObject<NSSecureCoding>

@property (nonatomic) BOOL useBudget;
@property (nonatomic) double budgetRemaining;
@property (retain, nonatomic) NSDate *startTime;
@property (readonly, nonatomic) NSDate *evaluatedUntil;

/* class methods */
+ (BOOL)supportsSecureCoding;

/* instance methods */
- (id)initWithStartTime:(id)time;
- (id)initWithStartTime:(id)time budget:(double)budget;
- (void)completeDisplayOnWithEndDate:(id)date;
- (double)calculateDisplayOnWithEvents:(id)events advertisements:(id)advertisements endDate:(id)date;
- (BOOL)isEqual:(id)equal;
- (id)initWithCoder:(id)coder;
- (void)encodeWithCoder:(id)coder;
@end

#endif /* TADisplayOnCalculator_h */