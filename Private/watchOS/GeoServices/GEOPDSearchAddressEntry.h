//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1940.42.9.28.8
//
#ifndef GEOPDSearchAddressEntry_h
#define GEOPDSearchAddressEntry_h
@import Foundation;

#include "PBCodable.h"
#include "GEOPDSearchEntry.h"
#include "NSCopying-Protocol.h"

@class NSMutableArray, PBDataReader;

@interface GEOPDSearchAddressEntry : PBCodable<NSCopying> {
  /* instance variables */
  PBDataReader *_reader;
  NSMutableArray *_candidates;
  GEOPDSearchEntry *_topResult;
  unsigned int _readerMarkPos;
  unsigned int _readerMarkLength;
  struct os_unfair_lock_s { unsigned int _os_unfair_lock_opaque; } _readerLock;
  struct { unsigned int x :1 read_candidates; unsigned int x :1 read_topResult; unsigned int x :1 wrote_anyField; } _flags;
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

#endif /* GEOPDSearchAddressEntry_h */