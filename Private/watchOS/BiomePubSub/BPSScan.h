//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 123.2.7.0.1
//
#ifndef BPSScan_h
#define BPSScan_h
@import Foundation;

#include "BMBookmarkablePublisher.h"
#include "BPSPublisher-Protocol.h"

@interface BPSScan : BMBookmarkablePublisher

@property (retain, nonatomic) id result;
@property (readonly, nonatomic) NSObject<BPSPublisher> *upstream;
@property (readonly, nonatomic) id initialResult;
@property (readonly, copy, nonatomic) id /* block */ nextPartialResult;

/* class methods */
+ (id)publisherWithPublisher:(id)publisher upstreams:(id)upstreams bookmarkState:(id)state;

/* instance methods */
- (id)bookmarkableUpstreams;
- (BOOL)canStoreInternalStateInBookmark;
- (BOOL)canStorePassThroughValueInBookmark;
- (id)initWithUpstream:(id)upstream initialResult:(id)result nextPartialResult:(id /* block */)result;
- (void)subscribe:(id)subscribe;
- (id)upstreamPublishers;
- (id)nextEvent;
- (void)reset;
- (id)bookmark;
- (void)applyBookmark:(id)bookmark;
@end

#endif /* BPSScan_h */