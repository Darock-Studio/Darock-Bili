//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3302.16.1.0.0
//
#ifndef INFERENCESchemaINFERENCESmartEnoughAppSelectionExecutionPathReported_h
#define INFERENCESchemaINFERENCESmartEnoughAppSelectionExecutionPathReported_h
@import Foundation;

#include "SISchemaInstrumentationMessage.h"

@class NSData;

@interface INFERENCESchemaINFERENCESmartEnoughAppSelectionExecutionPathReported : SISchemaInstrumentationMessage {
  /* instance variables */
  struct { unsigned int x :1 executionPath; unsigned int x :1 projectIntent; } _has;
}

@property (nonatomic) int executionPath;
@property (nonatomic) BOOL hasExecutionPath;
@property (nonatomic) int projectIntent;
@property (nonatomic) BOOL hasProjectIntent;
@property (readonly, nonatomic) NSData *jsonData;

/* instance methods */
- (id)suppressMessageUnderConditions;
- (void)deleteExecutionPath;
- (void)deleteProjectIntent;
- (BOOL)readFrom:(id)from;
- (void)writeTo:(id)to;
- (BOOL)isEqual:(id)equal;
- (unsigned long long)hash;
- (id)dictionaryRepresentation;
- (id)initWithJSON:(id)json;
- (id)initWithDictionary:(id)dictionary;
@end

#endif /* INFERENCESchemaINFERENCESmartEnoughAppSelectionExecutionPathReported_h */