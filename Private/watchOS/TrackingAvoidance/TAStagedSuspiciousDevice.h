//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 104.0.1.0.0
//
#ifndef TAStagedSuspiciousDevice_h
#define TAStagedSuspiciousDevice_h
@import Foundation;

#include "NSSecureCoding-Protocol.h"
#include "TASuspiciousDevice.h"

@class NSDate;

@interface TAStagedSuspiciousDevice : NSObject<NSSecureCoding>

@property (readonly, nonatomic) TASuspiciousDevice *detection;
@property (copy, nonatomic) NSDate *keepInStagingUntil;

/* class methods */
+ (BOOL)supportsSecureCoding;

/* instance methods */
- (id)initWithDetection:(id)detection keepInStagingUntil:(id)until;
- (BOOL)isEqual:(id)equal;
- (id)descriptionDictionary;
- (id)description;
- (id)initWithCoder:(id)coder;
- (void)encodeWithCoder:(id)coder;
@end

#endif /* TAStagedSuspiciousDevice_h */