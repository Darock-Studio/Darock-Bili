//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3302.16.1.0.0
//
#ifndef USOSchemaUSOEntityIdentifier_h
#define USOSchemaUSOEntityIdentifier_h
@import Foundation;

#include "SISchemaInstrumentationMessage.h"

@class NSData, NSString;

@interface USOSchemaUSOEntityIdentifier : SISchemaInstrumentationMessage {
  /* instance variables */
  struct { unsigned int x :1 nodeIndex; unsigned int x :1 probability; unsigned int x :1 sourceNluComponent; unsigned int x :1 backingAppBundleType; unsigned int x :1 groupIndex; unsigned int x :1 interpretationGroup; } _has;
}

@property (nonatomic) unsigned int nodeIndex;
@property (nonatomic) BOOL hasNodeIndex;
@property (copy, nonatomic) NSString *identifierNamespace;
@property (nonatomic) BOOL hasIdentifierNamespace;
@property (nonatomic) double probability;
@property (nonatomic) BOOL hasProbability;
@property (nonatomic) int sourceNluComponent;
@property (nonatomic) BOOL hasSourceNluComponent;
@property (nonatomic) int backingAppBundleType;
@property (nonatomic) BOOL hasBackingAppBundleType;
@property (nonatomic) unsigned int groupIndex;
@property (nonatomic) BOOL hasGroupIndex;
@property (nonatomic) unsigned int interpretationGroup;
@property (nonatomic) BOOL hasInterpretationGroup;
@property (readonly, nonatomic) NSData *jsonData;

/* instance methods */
- (id)suppressMessageUnderConditions;
- (void)deleteNodeIndex;
- (void)deleteIdentifierNamespace;
- (void)deleteProbability;
- (void)deleteSourceNluComponent;
- (void)deleteBackingAppBundleType;
- (void)deleteGroupIndex;
- (void)deleteInterpretationGroup;
- (BOOL)readFrom:(id)from;
- (void)writeTo:(id)to;
- (BOOL)isEqual:(id)equal;
- (unsigned long long)hash;
- (id)dictionaryRepresentation;
- (id)initWithJSON:(id)json;
- (id)initWithDictionary:(id)dictionary;
@end

#endif /* USOSchemaUSOEntityIdentifier_h */