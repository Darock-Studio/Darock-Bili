//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1552.3.6.1.1
//
#ifndef NSNumber_PKDecimalNumberAdditions_h
#define NSNumber_PKDecimalNumberAdditions_h
@import Foundation;

@interface NSNumber (PKDecimalNumberAdditions)
/* instance methods */
- (BOOL)pk_isIntegralNumber;
- (BOOL)pk_isNegativeNumber;
- (BOOL)pk_isPositiveNumber;
- (BOOL)pk_isZeroNumber;
- (BOOL)pk_isNotANumber;
@end

#endif /* NSNumber_PKDecimalNumberAdditions_h */