//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 720.1.0.0.0
//
#ifndef TPSAnalyticsEventProcessedUsageEvents_h
#define TPSAnalyticsEventProcessedUsageEvents_h
@import Foundation;

#include "TPSAnalyticsEvent.h"

@class NSDate, NSString, TPSExperiment;

@interface TPSAnalyticsEventProcessedUsageEvents : TPSAnalyticsEvent

@property (readonly, nonatomic) NSString *identifier;
@property (readonly, nonatomic) NSDate *firstShownDate;
@property (readonly, nonatomic) NSDate *notifiedDate;
@property (readonly, nonatomic) TPSExperiment *experiment;
@property (readonly, nonatomic) unsigned long long desiredOutcomeCount;
@property (readonly, nonatomic) unsigned long long preHintUsageCount;
@property (readonly, nonatomic) unsigned long long postHintUsageCount;
@property (readonly, nonatomic) BOOL preHintRangeOutOfBounds;
@property (readonly, nonatomic) BOOL postHintRangeOutOfBounds;
@property (readonly, nonatomic) BOOL overrideHoldout;

/* class methods */
+ (BOOL)supportsSecureCoding;

/* instance methods */
- (id)initWithUsageInfo:(id)info experiment:(id)experiment preHintUsageCount:(unsigned long long)count postHintUsageCount:(unsigned long long)count preHintRangeOutOfBounds:(BOOL)bounds postHintRangeOutOfBounds:(BOOL)bounds date:(id)date;
- (id)initWithCoder:(id)coder;
- (void)encodeWithCoder:(id)coder;
- (id)eventName;
- (id)mutableAnalyticsEventRepresentation;
@end

#endif /* TPSAnalyticsEventProcessedUsageEvents_h */