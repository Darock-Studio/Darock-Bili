//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 800.20.10.0.0
//
#ifndef WLKURLResponseDecoder_h
#define WLKURLResponseDecoder_h
@import Foundation;

#include "AMSURLResponseDecoder.h"

@interface WLKURLResponseDecoder : AMSURLResponseDecoder
/* class methods */
+ (void)logNetworkHeaders:(id)headers identifier:(id)identifier;

/* instance methods */
- (id)resultFromResult:(id)result error:(id *)error;
@end

#endif /* WLKURLResponseDecoder_h */