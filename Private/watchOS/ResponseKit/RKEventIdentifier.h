//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 200.0.0.0.0
//
#ifndef RKEventIdentifier_h
#define RKEventIdentifier_h
@import Foundation;

#include "RKMontrealModel.h"
#include "RKNLEventTokenizer.h"

@interface RKEventIdentifier : NSObject {
  /* instance variables */
  RKMontrealModel *_model;
  RKNLEventTokenizer *_tokenizer;
  const void * _ioMappings;
  int _outputPermutation[5];
}

/* instance methods */
- (id)init;
- (id)initWithLanguageID:(id)id;
- (void)resetEventIdentifierModel;
- (id)_identifyOwnedTokenSequences:(id)sequences;
- (id)_identifyStrings:(id)strings otherDateCount:(unsigned long long)count otherDates:(struct RKEventIdentifierRange { unsigned long long x0; struct _NSRange { unsigned long long x0; unsigned long long x1; } x1; } *)dates;
- (id)identifyStrings:(id)strings;
- (id)identifyText:(id)text;
- (id)identifyMessage:(id)message;
@end

#endif /* RKEventIdentifier_h */