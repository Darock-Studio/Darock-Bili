//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3300.28.1.0.0
//
#ifndef SASportsBaseballMatchup_h
#define SASportsBaseballMatchup_h
@import Foundation;

#include "SASportsMatchup.h"

@class NSNumber, NSString;

@interface SASportsBaseballMatchup : SASportsMatchup

@property (copy, nonatomic) NSNumber *awayErrors;
@property (copy, nonatomic) NSNumber *awayHits;
@property (copy, nonatomic) NSNumber *balls;
@property (copy, nonatomic) NSNumber *homeErrors;
@property (copy, nonatomic) NSNumber *homeHits;
@property (copy, nonatomic) NSString *inningStatus;
@property (copy, nonatomic) NSNumber *onFirst;
@property (copy, nonatomic) NSNumber *onSecond;
@property (copy, nonatomic) NSNumber *onThird;
@property (copy, nonatomic) NSNumber *outs;
@property (copy, nonatomic) NSNumber *strikes;

/* class methods */
+ (id)baseballMatchup;
+ (id)baseballMatchupWithDictionary:(id)dictionary context:(id)context;

/* instance methods */
- (id)groupIdentifier;
- (id)encodedClassName;
@end

#endif /* SASportsBaseballMatchup_h */