//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 388.0.0.0.0
//
#ifndef _PASSqliteNSDictionaryCursor_h
#define _PASSqliteNSDictionaryCursor_h
@import Foundation;

#include "_PASSqliteKeyValueCursor.h"

@class NSDictionary, NSEnumerator;

@interface _PASSqliteNSDictionaryCursor : _PASSqliteKeyValueCursor {
  /* instance variables */
  NSDictionary *_dictionary;
  NSEnumerator *_keysEnumerator;
  id _currentKey;
  id _currentValue;
  id _valueEqualTo;
}

@property (retain, @dynamic, nonatomic) NSDictionary *collection;

/* class methods */
+ (const char *)sqliteMethodName;
+ (id)planningInfoForKeyConstraint:(int)constraint;

/* instance methods */
- (void)applyKeyConstraint:(int)constraint withArgument:(id)argument;
- (void)finalizeConstraints;
- (id)currentIndexedKey;
- (id)currentIndexedValue;
- (BOOL)currentIndexedRowSatisfiesConstraints;
- (void)stepIndexedRow;
@end

#endif /* _PASSqliteNSDictionaryCursor_h */