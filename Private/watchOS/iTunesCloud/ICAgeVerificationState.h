//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 4023.330.5.0.0
//
#ifndef ICAgeVerificationState_h
#define ICAgeVerificationState_h
@import Foundation;

#include "ICAgeVerifier.h"
#include "ICUserIdentity.h"
#include "NSCopying-Protocol.h"

@class NSError, NSURL;

@interface ICAgeVerificationState : NSObject<NSCopying>

@property (readonly, copy, nonatomic) ICAgeVerifier *ageVerifier;
@property (readonly, nonatomic) BOOL dynamic;
@property (readonly, nonatomic) long long treatment;
@property (readonly, nonatomic) long long status;
@property (readonly, copy, nonatomic) NSURL *verificationURL;
@property (readonly, nonatomic) BOOL explicitContentAllowed;
@property (readonly, nonatomic) NSError *error;
@property (readonly, nonatomic) ICUserIdentity *userIdentity;

/* class methods */
+ (id)ageVerificationStateNotRequiredForUserIdentity:(id)identity;
+ (id)ageVerificationStateNotRequiredForUserIdentity:(id)identity withError:(id)error;
+ (id)ageVerificationStateNotRequiredForUserIdentity:(id)identity withTreatment:(long long)treatment;
+ (id)ageVerificationStateNotRequiredForUserIdentity:(id)identity withTreatment:(long long)treatment verificationURL:(id)url;
+ (id)cachedStateForDSID:(id)dsid;
+ (id)_stateFromDictionaryRepresentation:(id)representation DSID:(id)dsid;

/* instance methods */
- (id)_initWithUserIdentity:(id)identity status:(long long)status treatment:(long long)treatment verificationURL:(id)url error:(id)error;
- (id)initWithUserIdentity:(id)identity ageVerifier:(id)verifier treatment:(long long)treatment verificationURL:(id)url;
- (BOOL)isExplicitContentAllowed;
- (BOOL)isDynamic;
- (void)saveToUserDefaults;
- (id)copyWithZone:(struct _NSZone *)zone;
- (BOOL)isEqual:(id)equal;
- (id)description;
- (id)_dictionaryRepresentationWithDSID:(id)dsid;
@end

#endif /* ICAgeVerificationState_h */