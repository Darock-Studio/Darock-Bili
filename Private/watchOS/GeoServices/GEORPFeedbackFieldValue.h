//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1940.42.9.28.8
//
#ifndef GEORPFeedbackFieldValue_h
#define GEORPFeedbackFieldValue_h
@import Foundation;

#include "PBCodable.h"
#include "GEORPAmenityCorrections.h"
#include "GEORPFeedbackBooleanField.h"
#include "GEORPFeedbackCoordinateField.h"
#include "GEORPFeedbackDoubleField.h"
#include "GEORPFeedbackFieldAnnotations.h"
#include "GEORPFeedbackFloatField.h"
#include "GEORPFeedbackIntField.h"
#include "GEORPFeedbackLongField.h"
#include "GEORPFeedbackMultiSelectField.h"
#include "GEORPFeedbackRouteStep.h"
#include "GEORPFeedbackSingleSelectField.h"
#include "GEORPFeedbackTextField.h"
#include "GEORPFeedbackTextListField.h"
#include "GEORPFeedbackTileFeatureInfo.h"
#include "GEORPFeedbackTimestamp.h"
#include "GEORPFeedbackTransitLine.h"
#include "GEORPFeedbackUIntField.h"
#include "GEORPFeedbackULongField.h"
#include "GEORPFeedbackULongListField.h"
#include "NSCopying-Protocol.h"

@class NSMutableArray, PBDataReader;

@interface GEORPFeedbackFieldValue : PBCodable<NSCopying> {
  /* instance variables */
  PBDataReader *_reader;
  unsigned int _readerMarkPos;
  unsigned int _readerMarkLength;
  struct os_unfair_lock_s { unsigned int _os_unfair_lock_opaque; } _readerLock;
  struct { unsigned int x :1 has_fieldValueType; unsigned int x :1 read_amenitiesField; unsigned int x :1 read_annotations; unsigned int x :1 read_booleanField; unsigned int x :1 read_dateTimeField; unsigned int x :1 read_doubleField; unsigned int x :1 read_floatField; unsigned int x :1 read_hoursFields; unsigned int x :1 read_intField; unsigned int x :1 read_locationField; unsigned int x :1 read_longField; unsigned int x :1 read_multiSelectField; unsigned int x :1 read_photoMetadatas; unsigned int x :1 read_routeStepField; unsigned int x :1 read_singleSelectField; unsigned int x :1 read_textField; unsigned int x :1 read_textListField; unsigned int x :1 read_tileFeatureInfoField; unsigned int x :1 read_transitLineField; unsigned int x :1 read_uintField; unsigned int x :1 read_ulongField; unsigned int x :1 read_ulongListField; unsigned int x :1 wrote_anyField; } _flags;
}

@property (nonatomic) BOOL hasFieldValueType;
@property (nonatomic) int fieldValueType;
@property (readonly, nonatomic) BOOL hasSingleSelectField;
@property (retain, nonatomic) GEORPFeedbackSingleSelectField *singleSelectField;
@property (readonly, nonatomic) BOOL hasMultiSelectField;
@property (retain, nonatomic) GEORPFeedbackMultiSelectField *multiSelectField;
@property (readonly, nonatomic) BOOL hasTextField;
@property (retain, nonatomic) GEORPFeedbackTextField *textField;
@property (readonly, nonatomic) BOOL hasTextListField;
@property (retain, nonatomic) GEORPFeedbackTextListField *textListField;
@property (readonly, nonatomic) BOOL hasDateTimeField;
@property (retain, nonatomic) GEORPFeedbackTimestamp *dateTimeField;
@property (readonly, nonatomic) BOOL hasLocationField;
@property (retain, nonatomic) GEORPFeedbackCoordinateField *locationField;
@property (readonly, nonatomic) BOOL hasBooleanField;
@property (retain, nonatomic) GEORPFeedbackBooleanField *booleanField;
@property (readonly, nonatomic) BOOL hasLongField;
@property (retain, nonatomic) GEORPFeedbackLongField *longField;
@property (readonly, nonatomic) BOOL hasUlongField;
@property (retain, nonatomic) GEORPFeedbackULongField *ulongField;
@property (readonly, nonatomic) BOOL hasIntField;
@property (retain, nonatomic) GEORPFeedbackIntField *intField;
@property (readonly, nonatomic) BOOL hasUintField;
@property (retain, nonatomic) GEORPFeedbackUIntField *uintField;
@property (readonly, nonatomic) BOOL hasDoubleField;
@property (retain, nonatomic) GEORPFeedbackDoubleField *doubleField;
@property (readonly, nonatomic) BOOL hasFloatField;
@property (retain, nonatomic) GEORPFeedbackFloatField *floatField;
@property (retain, nonatomic) NSMutableArray *hoursFields;
@property (readonly, nonatomic) BOOL hasTileFeatureInfoField;
@property (retain, nonatomic) GEORPFeedbackTileFeatureInfo *tileFeatureInfoField;
@property (readonly, nonatomic) BOOL hasAmenitiesField;
@property (retain, nonatomic) GEORPAmenityCorrections *amenitiesField;
@property (readonly, nonatomic) BOOL hasUlongListField;
@property (retain, nonatomic) GEORPFeedbackULongListField *ulongListField;
@property (readonly, nonatomic) BOOL hasRouteStepField;
@property (retain, nonatomic) GEORPFeedbackRouteStep *routeStepField;
@property (readonly, nonatomic) BOOL hasTransitLineField;
@property (retain, nonatomic) GEORPFeedbackTransitLine *transitLineField;
@property (retain, nonatomic) NSMutableArray *photoMetadatas;
@property (readonly, nonatomic) BOOL hasAnnotations;
@property (retain, nonatomic) GEORPFeedbackFieldAnnotations *annotations;

/* class methods */
+ (Class)hoursFieldType;
+ (Class)photoMetadataType;
+ (BOOL)isValid:(id)valid;

/* instance methods */
- (id)init;
- (id)initWithData:(id)data;
- (id)fieldValueTypeAsString:(int)string;
- (int)StringAsFieldValueType:(id)type;
- (void)clearHoursFields;
- (void)addHoursField:(id)field;
- (unsigned long long)hoursFieldsCount;
- (id)hoursFieldAtIndex:(unsigned long long)index;
- (void)clearPhotoMetadatas;
- (void)addPhotoMetadata:(id)metadata;
- (unsigned long long)photoMetadatasCount;
- (id)photoMetadataAtIndex:(unsigned long long)index;
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
@end

#endif /* GEORPFeedbackFieldValue_h */