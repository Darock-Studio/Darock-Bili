//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 4023.330.5.0.0
//
#ifndef ICDelegationPlayInfoRequest_h
#define ICDelegationPlayInfoRequest_h
@import Foundation;

#include "NSCopying-Protocol.h"

@class NSArray, NSData, NSMutableDictionary, NSString;

@interface ICDelegationPlayInfoRequest : NSObject<NSCopying>

@property (copy, nonatomic) NSData *playerAnisetteMID;
@property (copy, nonatomic) NSString *playerDeviceGUID;
@property (copy, nonatomic) NSString *playerUserAgent;
@property (copy, nonatomic) NSArray *tokenRequests;
@property (readonly, copy, nonatomic) NSMutableDictionary *propertyListRepresentation;

/* instance methods */
- (id)copyWithZone:(struct _NSZone *)zone;
@end

#endif /* ICDelegationPlayInfoRequest_h */