//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 371.14.0.0.0
//
#ifndef DNDSKeybag_h
#define DNDSKeybag_h
@import Foundation;

#include "DNDSKeybagStateProviding-Protocol.h"

@class NSHashTable, NSString;
@protocol OS_dispatch_queue;

@interface DNDSKeybag : NSObject<DNDSKeybagStateProviding> {
  /* instance variables */
  NSObject<OS_dispatch_queue> *_calloutQueue;
  NSObject<OS_dispatch_queue> *_queue;
  NSHashTable *_queue_priorityObservers;
  BOOL _queue_priorityHasUnlockedSinceBoot;
  NSHashTable *_queue_observers;
  BOOL _queue_hasUnlockedSinceBoot;
}

@property (readonly, nonatomic) BOOL isLocked;
@property (readonly, nonatomic) BOOL hasUnlockedSinceBoot;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)sharedInstance;

/* instance methods */
- (id)init;
- (void)dealloc;
- (BOOL)_hasUnlockedSinceBootForObserver:(id)observer;
- (BOOL)hasUnlockedSinceBootForObserver:(id)observer;
- (void)addObserver:(id)observer;
- (void)addPriorityObserver:(id)observer;
- (void)removeObserver:(id)observer;
- (void)_beginObservingKeybag;
- (void)_queue_handleKeybagStatusChanged;
- (void)_queue_handleFirstUnlock;
@end

#endif /* DNDSKeybag_h */