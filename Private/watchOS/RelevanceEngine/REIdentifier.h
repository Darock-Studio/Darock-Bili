//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 472.0.0.0.0
//
#ifndef REIdentifier_h
#define REIdentifier_h
@import Foundation;

#include "NSString.h"
#include "NSCopying-Protocol.h"

@class NSString;

@interface REIdentifier : NSString<NSCopying> {
  /* instance variables */
  unsigned long long _hash;
  unsigned long long _length;
}

@property (readonly, nonatomic) NSString *dataSource;
@property (readonly, nonatomic) NSString *section;
@property (readonly, nonatomic) NSString *identifier;

/* instance methods */
- (id)initWithDataSource:(id)source section:(id)section identifier:(id)identifier;
- (BOOL)isEqualToString:(id)string;
- (BOOL)isEqual:(id)equal;
- (unsigned long long)hash;
- (unsigned long long)length;
- (unsigned short)characterAtIndex:(unsigned long long)index;
- (id)description;
- (id)copyWithZone:(struct _NSZone *)zone;
@end

#endif /* REIdentifier_h */