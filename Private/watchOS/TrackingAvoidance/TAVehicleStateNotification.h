//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 104.0.1.0.0
//
#ifndef TAVehicleStateNotification_h
#define TAVehicleStateNotification_h
@import Foundation;

#include "OSLogCoding-Protocol.h"
#include "TAEventProtocol-Protocol.h"

@class NSDate, NSString;

@interface TAVehicleStateNotification : NSObject<OSLogCoding, TAEventProtocol>

@property (readonly, copy, nonatomic) NSDate *date;
@property (readonly, nonatomic) unsigned long long vehicularState;
@property (readonly, nonatomic) unsigned long long vehicularHints;
@property (readonly, nonatomic) unsigned long long operatorState;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (BOOL)supportsSecureCoding;

/* instance methods */
- (id)initWithVehicularState:(unsigned long long)state andVehicularHints:(unsigned long long)hints andOperatorState:(unsigned long long)state date:(id)date;
- (BOOL)isEqual:(id)equal;
- (id)descriptionDictionary;
- (id)initWithCoder:(id)coder;
- (void)encodeWithCoder:(id)coder;
- (void)encodeWithOSLogCoder:(id)coder options:(unsigned long long)options maxLength:(unsigned long long)length;
- (id)copyWithZone:(struct _NSZone *)zone;
- (id)getDate;
@end

#endif /* TAVehicleStateNotification_h */