//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1940.42.9.28.8
//
#ifndef GEOMapsTransitWidget_h
#define GEOMapsTransitWidget_h
@import Foundation;

#include "PBCodable.h"
#include "NSCopying-Protocol.h"

@class NSMutableArray;

@interface GEOMapsTransitWidget : PBCodable<NSCopying> {
  /* instance variables */
  struct { unsigned int x :1 has_tappedItemIndex; unsigned int x :1 has_transitMessageType; unsigned int x :1 has_everExpanded; unsigned int x :1 has_initiallyExpanded; } _flags;
}

@property (nonatomic) BOOL hasTransitMessageType;
@property (nonatomic) int transitMessageType;
@property (retain, nonatomic) NSMutableArray *transitIncidentItems;
@property (nonatomic) BOOL hasInitiallyExpanded;
@property (nonatomic) BOOL initiallyExpanded;
@property (nonatomic) BOOL hasEverExpanded;
@property (nonatomic) BOOL everExpanded;
@property (nonatomic) BOOL hasTappedItemIndex;
@property (nonatomic) int tappedItemIndex;

/* class methods */
+ (Class)transitIncidentItemType;
+ (BOOL)isValid:(id)valid;

/* instance methods */
- (id)transitMessageTypeAsString:(int)string;
- (int)StringAsTransitMessageType:(id)type;
- (void)clearTransitIncidentItems;
- (void)addTransitIncidentItem:(id)item;
- (unsigned long long)transitIncidentItemsCount;
- (id)transitIncidentItemAtIndex:(unsigned long long)index;
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

#endif /* GEOMapsTransitWidget_h */