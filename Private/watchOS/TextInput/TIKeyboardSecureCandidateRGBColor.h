//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3431.206.0.0.0
//
#ifndef TIKeyboardSecureCandidateRGBColor_h
#define TIKeyboardSecureCandidateRGBColor_h
@import Foundation;

#include "NSCopying-Protocol.h"
#include "NSSecureCoding-Protocol.h"

@interface TIKeyboardSecureCandidateRGBColor : NSObject<NSCopying, NSSecureCoding>

@property (nonatomic) double colorR;
@property (nonatomic) double colorG;
@property (nonatomic) double colorB;
@property (nonatomic) double colorA;

/* class methods */
+ (id)whiteColor;
+ (id)blackColor;
+ (id)lightGrayColor;
+ (BOOL)supportsSecureCoding;

/* instance methods */
- (id)copyWithZone:(struct _NSZone *)zone;
- (id)initWithR:(double)r G:(double)g B:(double)b A:(double)a;
- (id)initWithCoder:(id)coder;
- (void)encodeWithCoder:(id)coder;
- (id)description;
- (BOOL)isEqual:(id)equal;
@end

#endif /* TIKeyboardSecureCandidateRGBColor_h */