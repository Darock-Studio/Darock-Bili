//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 4146.2.12.2.2
//
#ifndef HDCloudSyncCodableSharedSummaryParticipantRecord_h
#define HDCloudSyncCodableSharedSummaryParticipantRecord_h
@import Foundation;

#include "PBCodable.h"
#include "NSCopying-Protocol.h"

@class NSData, NSMutableArray, NSString;

@interface HDCloudSyncCodableSharedSummaryParticipantRecord : PBCodable<NSCopying> {
  /* instance variables */
  struct { unsigned int x :1 direction; unsigned int x :1 entryAcceptanceDate; unsigned int x :1 entryInvitationDate; unsigned int x :1 entryModificationDate; unsigned int x :1 notificationStatus; unsigned int x :1 status; unsigned int x :1 type; unsigned int x :1 userWheelchairMode; } _has;
}

@property (readonly, nonatomic) BOOL hasUuid;
@property (retain, nonatomic) NSString *uuid;
@property (readonly, nonatomic) BOOL hasContactIdentifier;
@property (retain, nonatomic) NSString *contactIdentifier;
@property (readonly, nonatomic) BOOL hasAuthorizationRecordIdentifier;
@property (retain, nonatomic) NSString *authorizationRecordIdentifier;
@property (readonly, nonatomic) BOOL hasCloudKitIdentifier;
@property (retain, nonatomic) NSString *cloudKitIdentifier;
@property (readonly, nonatomic) BOOL hasInvitationUUID;
@property (retain, nonatomic) NSString *invitationUUID;
@property (readonly, nonatomic) BOOL hasFirstName;
@property (retain, nonatomic) NSString *firstName;
@property (readonly, nonatomic) BOOL hasLastName;
@property (retain, nonatomic) NSString *lastName;
@property (retain, nonatomic) NSMutableArray *allContactIdentifiers;
@property (nonatomic) BOOL hasType;
@property (nonatomic) long long type;
@property (nonatomic) BOOL hasDirection;
@property (nonatomic) long long direction;
@property (nonatomic) BOOL hasStatus;
@property (nonatomic) long long status;
@property (nonatomic) BOOL hasNotificationStatus;
@property (nonatomic) long long notificationStatus;
@property (nonatomic) BOOL hasEntryModificationDate;
@property (nonatomic) double entryModificationDate;
@property (nonatomic) BOOL hasEntryInvitationDate;
@property (nonatomic) double entryInvitationDate;
@property (nonatomic) BOOL hasEntryAcceptanceDate;
@property (nonatomic) double entryAcceptanceDate;
@property (readonly, nonatomic) BOOL hasOwnerParticipant;
@property (retain, nonatomic) NSData *ownerParticipant;
@property (readonly, nonatomic) BOOL hasSetupMetadata;
@property (retain, nonatomic) NSData *setupMetadata;
@property (nonatomic) BOOL hasUserWheelchairMode;
@property (nonatomic) long long userWheelchairMode;

/* class methods */
+ (Class)allContactIdentifiersType;

/* instance methods */
- (void)clearAllContactIdentifiers;
- (void)addAllContactIdentifiers:(id)identifiers;
- (unsigned long long)allContactIdentifiersCount;
- (id)allContactIdentifiersAtIndex:(unsigned long long)index;
- (id)description;
- (id)dictionaryRepresentation;
- (BOOL)readFrom:(id)from;
- (void)writeTo:(id)to;
- (void)copyTo:(id)to;
- (id)copyWithZone:(struct _NSZone *)zone;
- (BOOL)isEqual:(id)equal;
- (unsigned long long)hash;
- (void)mergeFrom:(id)from;
@end

#endif /* HDCloudSyncCodableSharedSummaryParticipantRecord_h */