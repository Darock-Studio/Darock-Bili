//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 4146.2.12.2.2
//
#ifndef HKHRIrregularRhythmNotificationsBridgeFooter_h
#define HKHRIrregularRhythmNotificationsBridgeFooter_h
@import Foundation;

#include "NSCopying-Protocol.h"

@class NSString;

@interface HKHRIrregularRhythmNotificationsBridgeFooter : NSObject<NSCopying>

@property (readonly, copy, nonatomic) NSString *text;
@property (readonly, copy, nonatomic) NSString *linkText;
@property (readonly, copy, nonatomic) NSString *linkURL;

/* class methods */
+ (id)footerWhenAFibHistoryIsEnabled;
+ (id)footerWhenSeedHasExpired;
+ (id)footerWhenRemotelyDisabled;
+ (id)footerWhenUnavailableInOnboardedCountry;
+ (id)standardFooter;

/* instance methods */
- (id)initWithText:(id)text linkText:(id)text linkURL:(id)url;
- (id)copyWithZone:(struct _NSZone *)zone;
@end

#endif /* HKHRIrregularRhythmNotificationsBridgeFooter_h */