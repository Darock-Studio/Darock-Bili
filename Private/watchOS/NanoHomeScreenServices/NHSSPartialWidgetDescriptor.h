//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 2398.45.8.0.0
//
#ifndef NHSSPartialWidgetDescriptor_h
#define NHSSPartialWidgetDescriptor_h
@import Foundation;

#include "NSCopying-Protocol.h"
#include "NSSecureCoding-Protocol.h"

@class NSString;

@interface NHSSPartialWidgetDescriptor : NSObject<NSCopying, NSSecureCoding>

@property (copy, nonatomic) NSString *containerBundleIdentifier;
@property (copy, nonatomic) NSString *extensionBundleIdentifier;
@property (copy, nonatomic) NSString *kind;

/* class methods */
+ (BOOL)supportsSecureCoding;

/* instance methods */
- (BOOL)isEqual:(id)equal;
- (unsigned long long)hash;
- (id)copyWithZone:(struct _NSZone *)zone;
- (void)encodeWithCoder:(id)coder;
- (id)initWithCoder:(id)coder;
@end

#endif /* NHSSPartialWidgetDescriptor_h */