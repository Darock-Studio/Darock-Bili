//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 396.4.0.0.0
//
#ifndef TRIDownloadOptions_h
#define TRIDownloadOptions_h
@import Foundation;

#include "NSSecureCoding-Protocol.h"

@protocol OS_xpc_object;

@interface TRIDownloadOptions : NSObject<NSSecureCoding>

@property (retain, nonatomic) NSObject<OS_xpc_object> *activity;
@property (readonly, nonatomic) unsigned long long requiredCapability;
@property (nonatomic) BOOL allowsCellularAccess;
@property (nonatomic) BOOL allowsBatteryUsage;
@property (nonatomic) unsigned long long discretionaryBehavior;

/* class methods */
+ (id)inexpensiveOptions;
+ (BOOL)supportsSecureCoding;

/* instance methods */
- (id)init;
- (id)initWithAllowsCellular:(BOOL)cellular discretionaryBehavior:(unsigned long long)behavior;
- (id)initWithAllowsCellular:(BOOL)cellular discretionaryBehavior:(unsigned long long)behavior activity:(id)activity;
- (id)initFromPersistedBehavior:(id)behavior;
- (id)initWithCoder:(id)coder;
- (id)serializeToPersistedBehavior;
- (void)encodeWithCoder:(id)coder;
- (id)description;
- (BOOL)isEqual:(id)equal;
- (unsigned long long)hash;
@end

#endif /* TRIDownloadOptions_h */