//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 617.0.0.0.0
//
#ifndef FCColor_h
#define FCColor_h
@import Foundation;

#include "NSCopying-Protocol.h"

@class NSString;

@interface FCColor : NSObject<NSCopying>

@property (readonly, nonatomic) double red;
@property (readonly, nonatomic) double green;
@property (readonly, nonatomic) double blue;
@property (readonly, nonatomic) double alpha;
@property (readonly, nonatomic) NSString *hex;

/* class methods */
+ (id)colorWithRed:(double)red green:(double)green blue:(double)blue alpha:(double)alpha;
+ (id)colorWithHexString:(id)string;
+ (id)nullableColorWithHexString:(id)string;
+ (id)whiteColor;
+ (id)blackColor;
+ (id)clearColor;

/* instance methods */
- (id)init;
- (id)initWithRed:(double)red green:(double)green blue:(double)blue alpha:(double)alpha;
- (void)readDeconstructedRepresentationWithAcccessor:(id /* block */)acccessor;
- (BOOL)isSimilarToColor:(id)color withinPercentage:(double)percentage;
- (BOOL)isEqual:(id)equal;
- (unsigned long long)hash;
- (id)legibleColor;
- (id)copyWithZone:(struct _NSZone *)zone;
@end

#endif /* FCColor_h */