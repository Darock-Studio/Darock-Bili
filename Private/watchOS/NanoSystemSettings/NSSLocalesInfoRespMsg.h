//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 336.0.0.0.0
//
#ifndef NSSLocalesInfoRespMsg_h
#define NSSLocalesInfoRespMsg_h
@import Foundation;

#include "PBCodable.h"
#include "NSCopying-Protocol.h"

@class NSMutableArray, NSString;

@interface NSSLocalesInfoRespMsg : PBCodable<NSCopying>

@property (retain, nonatomic) NSMutableArray *systemLanguages;
@property (retain, nonatomic) NSMutableArray *localeIdentifiers;
@property (readonly, nonatomic) BOOL hasBuildVersion;
@property (retain, nonatomic) NSString *buildVersion;
@property (retain, nonatomic) NSMutableArray *supportedCalendars;
@property (retain, nonatomic) NSMutableArray *defaultCalendars;
@property (retain, nonatomic) NSMutableArray *numberingSystems;

/* class methods */
+ (Class)systemLanguagesType;
+ (Class)localeIdentifiersType;
+ (Class)supportedCalendarsType;
+ (Class)defaultCalendarsType;
+ (Class)numberingSystemsType;

/* instance methods */
- (void)clearSystemLanguages;
- (void)addSystemLanguages:(id)languages;
- (unsigned long long)systemLanguagesCount;
- (id)systemLanguagesAtIndex:(unsigned long long)index;
- (void)clearLocaleIdentifiers;
- (void)addLocaleIdentifiers:(id)identifiers;
- (unsigned long long)localeIdentifiersCount;
- (id)localeIdentifiersAtIndex:(unsigned long long)index;
- (void)clearSupportedCalendars;
- (void)addSupportedCalendars:(id)calendars;
- (unsigned long long)supportedCalendarsCount;
- (id)supportedCalendarsAtIndex:(unsigned long long)index;
- (void)clearDefaultCalendars;
- (void)addDefaultCalendars:(id)calendars;
- (unsigned long long)defaultCalendarsCount;
- (id)defaultCalendarsAtIndex:(unsigned long long)index;
- (void)clearNumberingSystems;
- (void)addNumberingSystems:(id)systems;
- (unsigned long long)numberingSystemsCount;
- (id)numberingSystemsAtIndex:(unsigned long long)index;
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

#endif /* NSSLocalesInfoRespMsg_h */