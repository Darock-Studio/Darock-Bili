//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1552.3.6.1.1
//
#ifndef PKEncryptedDataObject_h
#define PKEncryptedDataObject_h
@import Foundation;

#include "NSSecureCoding-Protocol.h"

@class NSData;

@interface PKEncryptedDataObject : NSObject<NSSecureCoding>

@property (nonatomic) unsigned long long version;
@property (copy, nonatomic) NSData *ephemeralPublicKey;
@property (copy, nonatomic) NSData *publicKeyHash;
@property (copy, nonatomic) NSData *data;

/* class methods */
+ (BOOL)supportsSecureCoding;

/* instance methods */
- (id)asWebServiceDictionary;
- (id)initWithWebServiceDictionary:(id)dictionary;
- (id)initWithCoder:(id)coder;
- (void)encodeWithCoder:(id)coder;
@end

#endif /* PKEncryptedDataObject_h */