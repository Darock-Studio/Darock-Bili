//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 2206.0.5.0.0
//
#ifndef WFTimeInterval_h
#define WFTimeInterval_h
@import Foundation;

#include "NSCopying-Protocol.h"
#include "NSSecureCoding-Protocol.h"
#include "WFSerializableContent-Protocol.h"

@class NSDateComponentsFormatter, NSString;

@interface WFTimeInterval : NSObject<NSCopying, WFSerializableContent, NSSecureCoding>

@property (readonly, nonatomic) NSDateComponentsFormatter *timeIntervalFormatter;
@property (readonly, nonatomic) double timeInterval;
@property (readonly, nonatomic) unsigned long long allowedUnits;
@property (readonly, nonatomic) long long unitsStyle;
@property (readonly, nonatomic) unsigned long long zeroFormattingBehavior;
@property (readonly, nonatomic) NSString *absoluteTimeString;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)objectWithWFSerializedRepresentation:(id)representation;
+ (BOOL)supportsSecureCoding;

/* instance methods */
- (id)initWithTimeInterval:(double)interval;
- (id)initWithTimeInterval:(double)interval allowedUnits:(unsigned long long)units unitsStyle:(long long)style zeroFormattingBehavior:(unsigned long long)behavior;
- (id)copyWithZone:(struct _NSZone *)zone;
- (BOOL)isEqual:(id)equal;
- (long long)compare:(id)compare;
- (id)wfName;
- (id)wfSerializedRepresentation;
- (void)encodeWithCoder:(id)coder;
- (id)initWithCoder:(id)coder;
@end

#endif /* WFTimeInterval_h */