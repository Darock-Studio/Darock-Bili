//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1940.42.9.28.8
//
#ifndef GEOListResultItem_h
#define GEOListResultItem_h
@import Foundation;

#include "PBCodable.h"
#include "NSCopying-Protocol.h"

@interface GEOListResultItem : PBCodable<NSCopying> {
  /* instance variables */
  struct { unsigned int x :1 has_businessId; unsigned int x :1 has_latency; unsigned int x :1 has_resultType; unsigned int x :1 has_tappedCount; unsigned int x :1 has_eventuallyVisible; unsigned int x :1 has_initiallyVisible; } _flags;
}

@property (nonatomic) BOOL hasResultType;
@property (nonatomic) int resultType;
@property (nonatomic) BOOL hasInitiallyVisible;
@property (nonatomic) BOOL initiallyVisible;
@property (nonatomic) BOOL hasEventuallyVisible;
@property (nonatomic) BOOL eventuallyVisible;
@property (nonatomic) BOOL hasLatency;
@property (nonatomic) long long latency;
@property (nonatomic) BOOL hasTappedCount;
@property (nonatomic) int tappedCount;
@property (nonatomic) BOOL hasBusinessId;
@property (nonatomic) unsigned long long businessId;

/* class methods */
+ (BOOL)isValid:(id)valid;

/* instance methods */
- (id)resultTypeAsString:(int)string;
- (int)StringAsResultType:(id)type;
- (id)description;
- (id)dictionaryRepresentation;
- (id)jsonRepresentation;
- (id)initWithDictionary:(id)dictionary;
- (id)initWithJSON:(id)json;
- (void)readAll:(BOOL)all;
- (BOOL)readFrom:(id)from;
- (void)writeTo:(id)to;
- (void)copyTo:(id)to;
- (id)copyWithZone:(struct _NSZone *)zone;
- (BOOL)isEqual:(id)equal;
- (unsigned long long)hash;
- (void)mergeFrom:(id)from;
@end

#endif /* GEOListResultItem_h */