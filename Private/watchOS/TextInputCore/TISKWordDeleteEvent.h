//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3431.206.0.0.0
//
#ifndef TISKWordDeleteEvent_h
#define TISKWordDeleteEvent_h
@import Foundation;

#include "TISKEvent.h"

@interface TISKWordDeleteEvent : TISKEvent
/* instance methods */
- (id)initWithEmojiSearchMode:(BOOL)mode order:(long long)order;
- (void)reportToSession:(id)session;
- (id)description;
@end

#endif /* TISKWordDeleteEvent_h */