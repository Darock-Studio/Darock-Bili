//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 295.0.0.0.0
//
#ifndef AAProcessorManager_AppAnalytics_h
#define AAProcessorManager_AppAnalytics_h
@import Foundation;

@interface AAProcessorManager (AppAnalytics) <AAFlushable>
/* instance methods */
- (void)resumeBackgroundProcessingForIdentifier:(id)identifier completion:(id /* block */)completion;
- (void)flushWithCallbackQueue:(id)queue completion:(id /* block */)completion;
- (void)addEventProcessor:(id)processor;
- (void)removeEventProcessor:(id)processor;
@end

#endif /* AAProcessorManager_AppAnalytics_h */