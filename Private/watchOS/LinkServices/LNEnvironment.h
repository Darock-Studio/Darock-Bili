//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 146.60.7.1.1
//
#ifndef LNEnvironment_h
#define LNEnvironment_h
@import Foundation;

#include "NSCopying-Protocol.h"
#include "NSSecureCoding-Protocol.h"

@class CLLocation, NSCalendar, NSMutableDictionary, NSString, NSTimeZone;

@interface LNEnvironment : NSObject<NSCopying, NSSecureCoding>

@property (retain, nonatomic) NSMutableDictionary *locationAuthorizationStatus;
@property (readonly, copy, nonatomic) NSString *localeIdentifier;
@property (copy, nonatomic) NSTimeZone *timeZone;
@property (copy, nonatomic) CLLocation *currentLocation;
@property (copy, nonatomic) NSCalendar *calendar;

/* class methods */
+ (id)defaultEnvironment;
+ (BOOL)supportsSecureCoding;

/* instance methods */
- (id)initWithLocaleIdentifier:(id)identifier;
- (id)trimLocation:(id)location atKeyPath:(id)path againstTCCWithBundleIdentifier:(id)identifier;
- (BOOL)locationAuthorizationStatusForBundleIdentifier:(id)identifier;
- (id)copyWithZone:(struct _NSZone *)zone;
- (void)encodeWithCoder:(id)coder;
- (id)initWithCoder:(id)coder;
@end

#endif /* LNEnvironment_h */