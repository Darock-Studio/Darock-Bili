//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1940.42.9.28.8
//
#ifndef GEOPDAutocompleteEntryQuery_h
#define GEOPDAutocompleteEntryQuery_h
@import Foundation;

#include "PBCodable.h"
#include "GEOStyleAttributes.h"
#include "NSCopying-Protocol.h"

@class NSMutableArray, NSString, PBDataReader, PBUnknownFields;

@interface GEOPDAutocompleteEntryQuery : PBCodable<NSCopying> {
  /* instance variables */
  PBDataReader *_reader;
  unsigned int _readerMarkPos;
  unsigned int _readerMarkLength;
  struct os_unfair_lock_s { unsigned int _os_unfair_lock_opaque; } _readerLock;
  struct { unsigned int x :1 has_tapBehavior; unsigned int x :1 has_queryHasAttributeIntentsInRefinements; unsigned int x :1 has_showIntermediateStateTapBehaviorListView; unsigned int x :1 read_unknownFields; unsigned int x :1 read_completion; unsigned int x :1 read_resultRefinements; unsigned int x :1 read_styleAttributes; unsigned int x :1 wrote_anyField; } _flags;
}

@property (readonly, nonatomic) BOOL hasCompletion;
@property (retain, nonatomic) NSString *completion;
@property (nonatomic) BOOL hasTapBehavior;
@property (nonatomic) int tapBehavior;
@property (nonatomic) BOOL hasShowIntermediateStateTapBehaviorListView;
@property (nonatomic) BOOL showIntermediateStateTapBehaviorListView;
@property (retain, nonatomic) NSMutableArray *resultRefinements;
@property (readonly, nonatomic) BOOL hasStyleAttributes;
@property (retain, nonatomic) GEOStyleAttributes *styleAttributes;
@property (nonatomic) BOOL hasQueryHasAttributeIntentsInRefinements;
@property (nonatomic) BOOL queryHasAttributeIntentsInRefinements;
@property (readonly, nonatomic) PBUnknownFields *unknownFields;

/* class methods */
+ (Class)resultRefinementType;
+ (BOOL)isValid:(id)valid;

/* instance methods */
- (id)init;
- (id)initWithData:(id)data;
- (id)tapBehaviorAsString:(int)string;
- (int)StringAsTapBehavior:(id)behavior;
- (void)clearResultRefinements;
- (void)addResultRefinement:(id)refinement;
- (unsigned long long)resultRefinementsCount;
- (id)resultRefinementAtIndex:(unsigned long long)index;
- (id)description;
- (id)dictionaryRepresentation;
- (id)jsonRepresentation;
- (id)initWithDictionary:(id)dictionary;
- (id)initWithJSON:(id)json;
- (void)readAll:(BOOL)all;
- (BOOL)readFrom:(id)from;
- (void)writeTo:(id)to;
- (BOOL)hasGreenTeaWithValue:(BOOL)value;
- (void)copyTo:(id)to;
- (id)copyWithZone:(struct _NSZone *)zone;
- (BOOL)isEqual:(id)equal;
- (unsigned long long)hash;
- (void)mergeFrom:(id)from;
- (void)clearUnknownFields:(BOOL)fields;
@end

#endif /* GEOPDAutocompleteEntryQuery_h */