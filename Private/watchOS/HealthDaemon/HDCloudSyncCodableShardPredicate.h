//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 4146.2.12.2.2
//
#ifndef HDCloudSyncCodableShardPredicate_h
#define HDCloudSyncCodableShardPredicate_h
@import Foundation;

#include "PBCodable.h"
#include "NSCopying-Protocol.h"

@interface HDCloudSyncCodableShardPredicate : PBCodable<NSCopying> {
  /* instance variables */
  struct { unsigned int x :1 endDate; unsigned int x :1 startDate; unsigned int x :1 type; } _has;
}

@property (nonatomic) BOOL hasType;
@property (nonatomic) int type;
@property (nonatomic) BOOL hasStartDate;
@property (nonatomic) double startDate;
@property (nonatomic) BOOL hasEndDate;
@property (nonatomic) double endDate;

/* instance methods */
- (id)typeAsString:(int)string;
- (int)StringAsType:(id)type;
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

#endif /* HDCloudSyncCodableShardPredicate_h */