//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 624.0.100.0.0
//
#ifndef PLSingleQuery_h
#define PLSingleQuery_h
@import Foundation;

#include "PBCodable.h"
#include "NSCopying-Protocol.h"
#include "PLQueryCircularRegion.h"

@class NSData, NSDate, NSString;

@interface PLSingleQuery : PBCodable<NSCopying> {
  /* instance variables */
  struct { unsigned int x :1 comparator; unsigned int x :1 key; unsigned int x :1 unit; unsigned int x :1 valueType; } _has;
}

@property (nonatomic) double doubleValue;
@property (nonatomic) double secondDoubleValue;
@property (nonatomic) long long integerValue;
@property (nonatomic) long long secondIntegerValue;
@property (nonatomic) BOOL boolValue;
@property (retain, nonatomic) NSString *stringValue;
@property (retain, nonatomic) NSString *secondStringValue;
@property (retain, nonatomic) NSDate *dateValue;
@property (retain, nonatomic) NSDate *secondDateValue;
@property (retain, nonatomic) PLQueryCircularRegion *circularRegionValue;
@property (retain, nonatomic) PLQueryCircularRegion *secondCircularRegionValue;
@property (nonatomic) BOOL hasKey;
@property (nonatomic) int key;
@property (nonatomic) BOOL hasValueType;
@property (nonatomic) int valueType;
@property (readonly, nonatomic) BOOL hasFirstValue;
@property (retain, nonatomic) NSData *firstValue;
@property (readonly, nonatomic) BOOL hasSecondValue;
@property (retain, nonatomic) NSData *secondValue;
@property (nonatomic) BOOL hasComparator;
@property (nonatomic) int comparator;
@property (nonatomic) BOOL hasUnit;
@property (nonatomic) int unit;

/* instance methods */
- (int)migratedComparator;
- (void)setValueAndType:(id)type;
- (id)logDescription;
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

#endif /* PLSingleQuery_h */