//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1852.4.7.0.3
//
#ifndef _PSRecipient_h
#define _PSRecipient_h
@import Foundation;

#include "NSSecureCoding-Protocol.h"

@class CNContact, NSString;

@interface _PSRecipient : NSObject<NSSecureCoding>

@property (copy, nonatomic) NSString *senderHandle;
@property (copy, nonatomic) NSString *givenName;
@property (copy, nonatomic) NSString *familyName;
@property (nonatomic) BOOL familyHeuristic;
@property (nonatomic) BOOL photosInference;
@property (copy, nonatomic) NSString *mostRecentTransportBundleId;
@property (copy, nonatomic) NSString *identifier;
@property (copy, nonatomic) NSString *handle;
@property (copy, nonatomic) NSString *handleString;
@property long long handleType;
@property (readonly, copy, nonatomic) NSString *displayName;
@property (retain, nonatomic) CNContact *contact;

/* class methods */
+ (id)recipientForINPerson:(id)inperson contactResolver:(id)resolver;
+ (BOOL)supportsSecureCoding;

/* instance methods */
- (id)initWithIdentifier:(id)identifier handle:(id)handle contact:(id)contact;
- (id)initWithIdentifier:(id)identifier handle:(id)handle displayName:(id)name contact:(id)contact;
- (id)initWithIdentifier:(id)identifier handle:(id)handle contact:(id)contact mostRecentTransportBundleId:(id)id;
- (id)initWithIdentifier:(id)identifier senderHandle:(id)handle handle:(id)handle displayName:(id)name contact:(id)contact;
- (id)initWithIdentifier:(id)identifier senderHandle:(id)handle handle:(id)handle displayName:(id)name contact:(id)contact mostRecentTransportBundleId:(id)id;
- (id)initWithCoder:(id)coder;
- (void)encodeWithCoder:(id)coder;
- (unsigned long long)hash;
- (BOOL)isEqual:(id)equal;
- (id)description;
@end

#endif /* _PSRecipient_h */