//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1431.300.81.0.0
//
#ifndef TUConversationParticipantCapabilities_h
#define TUConversationParticipantCapabilities_h
@import Foundation;

#include "NSCopying-Protocol.h"
#include "NSSecureCoding-Protocol.h"

@interface TUConversationParticipantCapabilities : NSObject<NSCopying, NSSecureCoding>

@property (nonatomic) BOOL momentsAvailable;
@property (nonatomic) BOOL screenSharingAvailable;
@property (nonatomic) BOOL gondolaCallingAvailable;
@property (nonatomic) BOOL personaAvailable;
@property (nonatomic) BOOL gftDowngradeToOneToOneAvailable;
@property (nonatomic) BOOL uPlusNDowngradeAvailable;
@property (nonatomic) BOOL uPlusOneScreenShareAvailable;
@property (nonatomic) BOOL uPlusOneAVLessAvailable;
@property (nonatomic) BOOL supportsLeaveContext;
@property (nonatomic) unsigned long long sharePlayProtocolVersion;
@property (nonatomic) unsigned long long visionFeatureVersion;
@property (nonatomic) unsigned long long visionCallEstablishmentVersion;

/* class methods */
+ (BOOL)supportsSecureCoding;

/* instance methods */
- (id)description;
- (BOOL)isEqual:(id)equal;
- (BOOL)isEqualToCapabilities:(id)capabilities;
- (unsigned long long)hash;
- (id)copyWithZone:(struct _NSZone *)zone;
- (id)initWithCoder:(id)coder;
- (void)encodeWithCoder:(id)coder;
- (BOOL)isMomentsAvailable;
- (BOOL)isScreenSharingAvailable;
- (BOOL)isGondolaCallingAvailable;
- (BOOL)isPersonaAvailable;
- (BOOL)isGFTDowngradeToOneToOneAvailable;
- (BOOL)isUPlusNDowngradeAvailable;
- (BOOL)isUPlusOneScreenShareAvailable;
- (BOOL)isUPlusOneAVLessAvailable;
@end

#endif /* TUConversationParticipantCapabilities_h */