//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1940.42.9.28.8
//
#ifndef GEOPDLocalizedQueryUnderstandingTaxonomyResultItemBrand_h
#define GEOPDLocalizedQueryUnderstandingTaxonomyResultItemBrand_h
@import Foundation;

#include "PBCodable.h"
#include "GEOLocalizedString.h"
#include "NSCopying-Protocol.h"

@class NSMutableArray, NSString, PBDataReader, PBUnknownFields;

@interface GEOPDLocalizedQueryUnderstandingTaxonomyResultItemBrand : PBCodable<NSCopying> {
  /* instance variables */
  PBDataReader *_reader;
  PBUnknownFields *_unknownFields;
  NSMutableArray *_categorys;
  NSString *_countryCode;
  unsigned long long _muid;
  GEOLocalizedString *_prefDisplayName;
  NSString *_prefPhone;
  NSString *_prefUrl;
  unsigned int _readerMarkPos;
  unsigned int _readerMarkLength;
  struct os_unfair_lock_s { unsigned int _os_unfair_lock_opaque; } _readerLock;
  struct { unsigned int x :1 has_muid; unsigned int x :1 read_unknownFields; unsigned int x :1 read_categorys; unsigned int x :1 read_countryCode; unsigned int x :1 read_prefDisplayName; unsigned int x :1 read_prefPhone; unsigned int x :1 read_prefUrl; unsigned int x :1 wrote_anyField; } _flags;
}

/* instance methods */
- (id)init;
- (id)initWithData:(id)data;
- (id)description;
- (id)dictionaryRepresentation;
- (id)jsonRepresentation;
- (BOOL)readFrom:(id)from;
- (void)writeTo:(id)to;
- (id)copyWithZone:(struct _NSZone *)zone;
- (BOOL)isEqual:(id)equal;
- (unsigned long long)hash;
@end

#endif /* GEOPDLocalizedQueryUnderstandingTaxonomyResultItemBrand_h */