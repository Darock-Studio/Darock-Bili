//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1226.2.2.1.0
//
#ifndef PPTripPart_h
#define PPTripPart_h
@import Foundation;

#include "NSSecureCoding-Protocol.h"

@class CLPlacemark, NSArray, NSDate, NSString;

@interface PPTripPart : NSObject<NSSecureCoding>

@property (readonly, nonatomic) NSArray *eventIdentifiers;
@property (readonly, nonatomic) NSDate *startDate;
@property (readonly, nonatomic) NSDate *endDate;
@property (readonly, nonatomic) NSString *startLocation;
@property (readonly, nonatomic) NSString *endLocation;
@property (retain, nonatomic) CLPlacemark *mainLocation;
@property (retain, nonatomic) NSString *fallbackLocationString;
@property (readonly, nonatomic) unsigned char tripMode;

/* class methods */
+ (BOOL)supportsSecureCoding;
+ (id)descriptionForTripMode:(unsigned char)mode;

/* instance methods */
- (id)initWithStartDate:(id)date endDate:(id)date eventIdentifiers:(id)identifiers mode:(unsigned char)mode location:(id)location fallbackLocationString:(id)string;
- (id)initWithCoder:(id)coder;
- (void)encodeWithCoder:(id)coder;
- (id)destinationString;
- (id)description;
@end

#endif /* PPTripPart_h */