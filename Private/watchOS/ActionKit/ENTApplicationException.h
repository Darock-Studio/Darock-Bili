//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 2206.0.5.0.0
//
#ifndef ENTApplicationException_h
#define ENTApplicationException_h
@import Foundation;

#include "ENTException.h"

@interface ENTApplicationException : ENTException {
  /* instance variables */
  int _type;
}

/* class methods */
+ (id)read:(id)read;
+ (id)exceptionWithType:(int)type reason:(id)reason;

/* instance methods */
- (id)initWithType:(int)type reason:(id)reason;
- (void)write:(id)write;
@end

#endif /* ENTApplicationException_h */