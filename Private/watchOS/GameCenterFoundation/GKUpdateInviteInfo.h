//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 818.2.23.4.1
//
#ifndef GKUpdateInviteInfo_h
#define GKUpdateInviteInfo_h
@import Foundation;

#include "GKInternalRepresentation.h"

@class NSData, NSDictionary, NSNumber, NSSet, NSString;

@interface GKUpdateInviteInfo : GKInternalRepresentation

@property (retain, nonatomic) NSSet *gameParticipants;
@property (retain, nonatomic) NSSet *lobbyParticipants;
@property (retain, nonatomic) NSDictionary *playerTokenMap;
@property (retain, nonatomic) NSString *sessionID;
@property (retain, nonatomic) NSData *sessionToken;
@property (retain, nonatomic) NSString *matchID;
@property (retain, nonatomic) NSNumber *transportVersionToUse;

/* class methods */
+ (id)secureCodedPropertyKeys;

/* instance methods */
- (id)description;
- (void)mergeWithUpdate:(id)update;
@end

#endif /* GKUpdateInviteInfo_h */