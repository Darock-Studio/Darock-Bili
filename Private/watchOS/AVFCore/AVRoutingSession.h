//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 2220.14.1.0.0
//
#ifndef AVRoutingSession_h
#define AVRoutingSession_h
@import Foundation;

#include "AVRoutingSessionDestination.h"

@class AVRoutingSessionInternal;

@interface AVRoutingSession : NSObject {
  /* instance variables */
  AVRoutingSessionInternal *_ivars;
}

@property (readonly) AVRoutingSessionDestination *destination;
@property (readonly) BOOL establishedAutomaticallyFromLikelyDestination;

/* instance methods */
- (void)dealloc;
@end

#endif /* AVRoutingSession_h */