//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1552.3.6.1.1
//
#ifndef PKVerificationRequestRecord_h
#define PKVerificationRequestRecord_h
@import Foundation;

#include "NSSecureCoding-Protocol.h"
#include "PKVerificationChannel.h"

@class NSArray, NSDate, NSDictionary, NSString;

@interface PKVerificationRequestRecord : NSObject<NSSecureCoding>

@property (copy, nonatomic) NSString *currentStepIdentifier;
@property (copy, nonatomic) NSString *previousStepIdentifier;
@property (nonatomic) long long verificationStatus;
@property (copy, nonatomic) NSString *passUniqueID;
@property (copy, nonatomic) NSDate *date;
@property (copy, nonatomic) PKVerificationChannel *channel;
@property (copy, nonatomic) NSArray *allChannels;
@property (copy, nonatomic) NSDictionary *requiredFieldData;

/* class methods */
+ (id)verificationRequestRecordForPass:(id)pass;
+ (BOOL)supportsSecureCoding;

/* instance methods */
- (id)initWithCoder:(id)coder;
- (void)encodeWithCoder:(id)coder;
- (id)description;
- (id)requiredVerificationFields;
@end

#endif /* PKVerificationRequestRecord_h */