//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1552.3.6.1.1
//
#ifndef PKPeerPaymentRecipient_h
#define PKPeerPaymentRecipient_h
@import Foundation;

#include "NSCopying-Protocol.h"
#include "NSSecureCoding-Protocol.h"

@class NSDate, NSDecimalNumber, NSString;

@interface PKPeerPaymentRecipient : NSObject<NSSecureCoding, NSCopying>

@property (copy, nonatomic) NSString *identifier;
@property (nonatomic) unsigned long long status;
@property (nonatomic) unsigned long long statusReason;
@property (nonatomic) unsigned long long receiveMethod;
@property (copy, nonatomic) NSString *receiveCurrency;
@property (copy, nonatomic) NSDecimalNumber *minimumReceiveAmount;
@property (copy, nonatomic) NSDecimalNumber *maximumReceiveAmount;
@property (nonatomic) BOOL allowsFormalPaymentRequests;
@property (copy, nonatomic) NSDate *cacheUntil;
@property (copy, nonatomic) NSString *phoneOrEmail;
@property (copy, nonatomic) NSString *displayName;

/* class methods */
+ (id)recipientWithDictionary:(id)dictionary;
+ (BOOL)supportsSecureCoding;

/* instance methods */
- (id)initWithDictionary:(id)dictionary;
- (id)copyWithZone:(struct _NSZone *)zone;
- (id)cacheableCopy;
- (id)initWithCoder:(id)coder;
- (void)encodeWithCoder:(id)coder;
- (unsigned long long)hash;
- (BOOL)isEqual:(id)equal;
- (id)description;
@end

#endif /* PKPeerPaymentRecipient_h */