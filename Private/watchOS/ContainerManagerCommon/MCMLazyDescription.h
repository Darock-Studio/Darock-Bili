//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 582.60.2.0.0
//
#ifndef MCMLazyDescription_h
#define MCMLazyDescription_h
@import Foundation;

#include "NSString.h"

@class NSString;

@interface MCMLazyDescription : NSString {
  /* instance variables */
  id /* block */ _block;
  NSString *_value;
}

/* instance methods */
- (id)initWithDescriber:(id /* block */)describer;
- (unsigned long long)length;
- (unsigned short)characterAtIndex:(unsigned long long)index;
- (void)getCharacters:(unsigned short *)characters range:(struct _NSRange { unsigned long long x0; unsigned long long x1; })range;
- (id)description;
- (id)redactedDescription;
@end

#endif /* MCMLazyDescription_h */