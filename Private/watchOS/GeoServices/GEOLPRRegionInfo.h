//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1940.42.9.28.8
//
#ifndef GEOLPRRegionInfo_h
#define GEOLPRRegionInfo_h
@import Foundation;

#include "PBCodable.h"
#include "NSCopying-Protocol.h"

@class NSMutableArray, NSString, PBDataReader;

@interface GEOLPRRegionInfo : PBCodable<NSCopying> {
  /* instance variables */
  PBDataReader *_reader;
  unsigned int _readerMarkPos;
  unsigned int _readerMarkLength;
  struct os_unfair_lock_s { unsigned int _os_unfair_lock_opaque; } _readerLock;
  struct { unsigned int x :1 read_routingRequiredFields; unsigned int x :1 read_licensePlateTemplate; unsigned int x :1 read_licensePlateValidationRules; unsigned int x :1 read_validPowerTypeKeys; unsigned int x :1 read_validVehicleTypeKeys; unsigned int x :1 wrote_anyField; } _flags;
}

@property (readonly, nonatomic) unsigned long long routingRequiredFieldsCount;
@property (readonly, nonatomic) int * routingRequiredFields;
@property (retain, nonatomic) NSMutableArray *validPowerTypeKeys;
@property (retain, nonatomic) NSMutableArray *validVehicleTypeKeys;
@property (readonly, nonatomic) BOOL hasLicensePlateTemplate;
@property (retain, nonatomic) NSString *licensePlateTemplate;
@property (retain, nonatomic) NSMutableArray *licensePlateValidationRules;

/* class methods */
+ (Class)validPowerTypeKeysType;
+ (Class)validVehicleTypeKeysType;
+ (Class)licensePlateValidationRulesType;
+ (BOOL)isValid:(id)valid;

/* instance methods */
- (id)init;
- (id)initWithData:(id)data;
- (void)dealloc;
- (void)clearRoutingRequiredFields;
- (void)addRoutingRequiredFields:(int)fields;
- (int)routingRequiredFieldsAtIndex:(unsigned long long)index;
- (void)setRoutingRequiredFields:(int *)fields count:(unsigned long long)count;
- (id)routingRequiredFieldsAsString:(int)string;
- (int)StringAsRoutingRequiredFields:(id)fields;
- (void)clearValidPowerTypeKeys;
- (void)addValidPowerTypeKeys:(id)keys;
- (unsigned long long)validPowerTypeKeysCount;
- (id)validPowerTypeKeysAtIndex:(unsigned long long)index;
- (void)clearValidVehicleTypeKeys;
- (void)addValidVehicleTypeKeys:(id)keys;
- (unsigned long long)validVehicleTypeKeysCount;
- (id)validVehicleTypeKeysAtIndex:(unsigned long long)index;
- (void)clearLicensePlateValidationRules;
- (void)addLicensePlateValidationRules:(id)rules;
- (unsigned long long)licensePlateValidationRulesCount;
- (id)licensePlateValidationRulesAtIndex:(unsigned long long)index;
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

#endif /* GEOLPRRegionInfo_h */