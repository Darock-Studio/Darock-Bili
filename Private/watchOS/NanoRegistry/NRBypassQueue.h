//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 920.3.0.0.0
//
#ifndef NRBypassQueue_h
#define NRBypassQueue_h
@import Foundation;

@protocol OS_dispatch_queue;

@interface NRBypassQueue : NSObject {
  /* instance variables */
  NSObject<OS_dispatch_queue> *_suspendableQueue;
  NSObject<OS_dispatch_queue> *_bypassQueue;
  BOOL _suspended;
  struct os_unfair_lock_s { unsigned int _os_unfair_lock_opaque; } _lock;
}

/* instance methods */
- (id)init;
- (void)enqueueBlock:(id /* block */)block;
- (void)enqueueBlockAsync:(id /* block */)async;
- (void)enqueueBypassBlock:(id /* block */)block;
- (void)enqueueBypassBlockAsync:(id /* block */)async;
- (void)suspend;
- (void)resume;
- (void)invalidate;
@end

#endif /* NRBypassQueue_h */