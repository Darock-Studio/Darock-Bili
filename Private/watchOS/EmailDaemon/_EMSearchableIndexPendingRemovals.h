//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3774.300.42.0.0
//
#ifndef _EMSearchableIndexPendingRemovals_h
#define _EMSearchableIndexPendingRemovals_h
@import Foundation;

#include "NSCopying-Protocol.h"

@class NSArray, NSMutableDictionary, NSSet;

@interface _EMSearchableIndexPendingRemovals : NSObject<NSCopying> {
  /* instance variables */
  NSMutableDictionary *_reasonsByIdentifier;
}

@property (readonly) unsigned long long count;
@property (readonly, nonatomic) NSArray *identifiers;
@property (readonly, nonatomic) NSArray *purgedIdentifiers;
@property (readonly, nonatomic) NSArray *deletedIdentifiers;
@property (copy, nonatomic) NSSet *purgeReasons;
@property (copy, nonatomic) NSSet *exclusionReasons;

/* instance methods */
- (id)initWithPurgeReasons:(id)reasons exclusionReasons:(id)reasons;
- (id)copyWithZone:(struct _NSZone *)zone;
- (id)_identifiersPassingReasonsTest:(id /* block */)test;
- (void)addIdentifiers:(id)identifiers withReasons:(id)reasons;
- (void)removeIdentifier:(id)identifier;
- (void)removeAllIdentifiers;
@end

#endif /* _EMSearchableIndexPendingRemovals_h */