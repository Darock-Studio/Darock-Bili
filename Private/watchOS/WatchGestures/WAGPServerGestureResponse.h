//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 114.2.2.0.0
//
#ifndef WAGPServerGestureResponse_h
#define WAGPServerGestureResponse_h
@import Foundation;

#include "PBCodable.h"
#include "NSCopying-Protocol.h"
#include "WAGPError.h"
#include "WAGPGestureResponse.h"

@interface WAGPServerGestureResponse : PBCodable<NSCopying>

@property (readonly, nonatomic) BOOL hasGestureResponse;
@property (retain, nonatomic) WAGPGestureResponse *gestureResponse;
@property (readonly, nonatomic) BOOL hasError;
@property (retain, nonatomic) WAGPError *error;

/* instance methods */
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

#endif /* WAGPServerGestureResponse_h */