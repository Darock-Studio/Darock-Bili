//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 767.3.3.0.0
//
#ifndef HMFVersion_h
#define HMFVersion_h
@import Foundation;

#include "HMFObject.h"
#include "HMFLocalizable-Protocol.h"
#include "HMFLogging-Protocol.h"
#include "NSCopying-Protocol.h"
#include "NSSecureCoding-Protocol.h"

@class NSString;

@interface HMFVersion : HMFObject<HMFLogging, HMFLocalizable, NSCopying, NSSecureCoding>

@property (readonly) unsigned long long majorVersion;
@property (readonly) unsigned long long minorVersion;
@property (readonly) unsigned long long updateVersion;
@property (readonly, copy) NSString *versionString;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;
@property (readonly, copy) NSString *localizedDescription;

/* class methods */
+ (BOOL)supportsSecureCoding;
+ (id)logCategory;

/* instance methods */
- (id)init;
- (id)initWithMajorVersion:(unsigned long long)version minorVersion:(unsigned long long)version updateVersion:(unsigned long long)version;
- (id)initWithVersionString:(id)string;
- (BOOL)isEqual:(id)equal;
- (long long)compare:(id)compare;
- (BOOL)isEqualToVersion:(id)version;
- (BOOL)isAtLeastVersion:(id)version;
- (BOOL)isGreaterThanVersion:(id)version;
- (id)copyWithZone:(struct _NSZone *)zone;
- (id)initWithCoder:(id)coder;
- (void)encodeWithCoder:(id)coder;
@end

#endif /* HMFVersion_h */