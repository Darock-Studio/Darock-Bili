//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 45.2.1.0.0
//
#ifndef WNAlertActivationRequest_h
#define WNAlertActivationRequest_h
@import Foundation;

#include "BSDescriptionProviding-Protocol.h"
#include "NSCopying-Protocol.h"
#include "NSSecureCoding-Protocol.h"
#include "WNAlertClientContext.h"

@class NSSet, NSString;

@interface WNAlertActivationRequest : NSObject<BSDescriptionProviding, NSCopying, NSSecureCoding>

@property (nonatomic) BOOL CUISAlertProviderAdapter;
@property (nonatomic) BOOL animated;
@property (retain, nonatomic) WNAlertClientContext *clientContext;
@property (copy, nonatomic) NSSet *activationConditions;
@property (copy, nonatomic) NSSet *attributes;
@property (copy, nonatomic) NSSet *actions;
@property (nonatomic) BOOL preflightOnly;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (BOOL)supportsSecureCoding;

/* instance methods */
- (id)init;
- (id)initWithRequest:(id)request;
- (id)copyWithZone:(struct _NSZone *)zone;
- (void)encodeWithCoder:(id)coder;
- (id)initWithCoder:(id)coder;
- (id)succinctDescriptionBuilder;
- (id)succinctDescription;
- (id)descriptionBuilderWithMultilinePrefix:(id)prefix;
- (id)descriptionWithMultilinePrefix:(id)prefix;
- (BOOL)isAnimated;
- (BOOL)isPreflightOnly;
- (BOOL)isCUISAlertProviderAdapter;
@end

#endif /* WNAlertActivationRequest_h */