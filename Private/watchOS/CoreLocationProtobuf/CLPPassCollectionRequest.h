//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 160.0.2.0.0
//
#ifndef CLPPassCollectionRequest_h
#define CLPPassCollectionRequest_h
@import Foundation;

#include "PBRequest.h"
#include "CLPMeta.h"
#include "NSCopying-Protocol.h"

@class NSData, NSMutableArray;

@interface CLPPassCollectionRequest : PBRequest<NSCopying>

@property (retain, nonatomic) CLPMeta *meta;
@property (retain, nonatomic) NSMutableArray *passLocations;
@property (readonly, nonatomic) BOOL hasSignature;
@property (retain, nonatomic) NSData *signature;

/* class methods */
+ (Class)passLocationType;

/* instance methods */
- (void)clearPassLocations;
- (void)addPassLocation:(id)location;
- (unsigned long long)passLocationsCount;
- (id)passLocationAtIndex:(unsigned long long)index;
- (id)description;
- (id)dictionaryRepresentation;
- (BOOL)readFrom:(id)from;
- (void)writeTo:(id)to;
- (unsigned int)requestTypeCode;
- (Class)responseClass;
- (void)copyTo:(id)to;
- (id)copyWithZone:(struct _NSZone *)zone;
- (BOOL)isEqual:(id)equal;
- (unsigned long long)hash;
- (void)mergeFrom:(id)from;
@end

#endif /* CLPPassCollectionRequest_h */