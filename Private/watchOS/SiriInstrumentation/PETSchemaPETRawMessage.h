//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3302.16.1.0.0
//
#ifndef PETSchemaPETRawMessage_h
#define PETSchemaPETRawMessage_h
@import Foundation;

#include "SISchemaInstrumentationMessage.h"

@class NSData, NSString;

@interface PETSchemaPETRawMessage : SISchemaInstrumentationMessage {
  /* instance variables */
  struct { unsigned int x :1 type_id; } _has;
}

@property (nonatomic) unsigned int type_id;
@property (nonatomic) BOOL hasType_id;
@property (copy, nonatomic) NSData *raw_bytes;
@property (nonatomic) BOOL hasRaw_bytes;
@property (copy, nonatomic) NSString *name;
@property (nonatomic) BOOL hasName;
@property (readonly, nonatomic) NSData *jsonData;

/* instance methods */
- (id)suppressMessageUnderConditions;
- (void)deleteType_id;
- (void)deleteRaw_bytes;
- (void)deleteName;
- (BOOL)readFrom:(id)from;
- (void)writeTo:(id)to;
- (BOOL)isEqual:(id)equal;
- (unsigned long long)hash;
- (id)dictionaryRepresentation;
- (id)initWithJSON:(id)json;
- (id)initWithDictionary:(id)dictionary;
@end

#endif /* PETSchemaPETRawMessage_h */