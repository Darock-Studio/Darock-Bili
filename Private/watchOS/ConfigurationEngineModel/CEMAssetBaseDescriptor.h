//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 171.0.0.0.0
//
#ifndef CEMAssetBaseDescriptor_h
#define CEMAssetBaseDescriptor_h
@import Foundation;

#include "CEMPayloadBase.h"

@class NSString;

@interface CEMAssetBaseDescriptor : CEMPayloadBase

@property (copy, nonatomic) NSString *payloadTitle;
@property (copy, nonatomic) NSString *payloadDescription;

/* class methods */
+ (id)allowedPayloadKeys;
+ (id)buildWithTitle:(id)title withDescription:(id)description;
+ (id)buildRequiredOnlyWithTitle:(id)title;

/* instance methods */
- (BOOL)loadPayload:(id)payload error:(id *)error;
- (id)serializePayloadWithAssetProviders:(id)providers;
- (id)copyWithZone:(struct _NSZone *)zone;
@end

#endif /* CEMAssetBaseDescriptor_h */