//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 158.42.9.28.10
//
#ifndef MUAMSResultProvider_h
#define MUAMSResultProvider_h
@import Foundation;

#include "MUAMSResultCache.h"

@protocol OS_dispatch_queue;

@interface MUAMSResultProvider : NSObject {
  /* instance variables */
  MUAMSResultCache *_amsResultCache;
  NSObject<OS_dispatch_queue> *_queue;
}

/* instance methods */
- (id)initWithCache:(id)cache;
- (void)fetchResultsForAdamIds:(id)ids options:(id)options callbackQueue:(id)queue completion:(id /* block */)completion;
- (void)fetchResultsForBundleIds:(id)ids options:(id)options callbackQueue:(id)queue completion:(id /* block */)completion;
- (void)_finishWithResults:(id)results error:(id)error onCallbackQueue:(id)queue completion:(id /* block */)completion;
@end

#endif /* MUAMSResultProvider_h */