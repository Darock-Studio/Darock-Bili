//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 598.10.0.0.0
//
#ifndef BKSHIDEventObserver_h
#define BKSHIDEventObserver_h
@import Foundation;

@class BSServiceConnection, NSMapTable, NSSet;
@protocol OS_dispatch_queue;

@interface BKSHIDEventObserver : NSObject {
  /* instance variables */
  NSObject<OS_dispatch_queue> *_calloutQueue;
  struct os_unfair_lock_s { unsigned int _os_unfair_lock_opaque; } _lock;
  NSMapTable *_lock_deferringAssertionsToObservers;
  NSSet *_lock_deferringResolutions;
  BSServiceConnection *_connection;
}

@property (readonly, @dynamic, nonatomic) NSSet *deferringResolutions;

/* class methods */
+ (id)sharedInstance;

/* instance methods */
- (id)init;
- (id)_init;
- (id)addDeferringObserver:(id)observer;
- (void)_lock_enableObservation;
- (void)_lock_disableObservation;
- (void)didUpdateDeferringResolutions:(id)resolutions;
@end

#endif /* BKSHIDEventObserver_h */