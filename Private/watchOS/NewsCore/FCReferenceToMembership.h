//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 617.0.0.0.0
//
#ifndef FCReferenceToMembership_h
#define FCReferenceToMembership_h
@import Foundation;

@class NSString;

@interface FCReferenceToMembership : NSObject

@property (readonly, nonatomic) NSString *identifier;
@property (readonly, nonatomic) NSString *membershipID;

/* instance methods */
- (id)initWithIdentifier:(id)identifier;
- (id)initWithRecord:(id)record;
- (id)initWithIdentifier:(id)identifier dictionaryRepresentation:(id)representation;
- (id)dictionaryRepresentation;
@end

#endif /* FCReferenceToMembership_h */