//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 491.7.0.0.0
//
#ifndef UNSContentProtectionManager_h
#define UNSContentProtectionManager_h
@import Foundation;

#include "UNSKeyedObservable.h"

@protocol OS_dispatch_queue;

@interface UNSContentProtectionManager : NSObject {
  /* instance variables */
  long long _contentProtectionState;
  BOOL _unlockedSinceBoot;
  int _notifyToken;
  NSObject<OS_dispatch_queue> *_queue;
  UNSKeyedObservable *_observable;
}

/* instance methods */
- (id)init;
- (void)dealloc;
- (void)addContentProtectionObserver:(id)observer;
- (void)removeContentProtectionObserver:(id)observer;
- (long long)observedState;
- (BOOL)isProtectedDataAvailable;
- (BOOL)deviceUnlockedSinceBoot;
- (id)classCStrategy;
- (id)classDStrategy;
- (id)classCStrategyExcludedFromBackup;
- (id)classDStrategyExcludedFromBackup;
- (id)contentProtectionStrategyForMinimumProtection:(id)protection excludedFromBackup:(BOOL)backup;
- (long long)_queue_observedState;
- (void)_queue_adjustContentProtectionStateWithBlock:(id /* block */)block;
@end

#endif /* UNSContentProtectionManager_h */