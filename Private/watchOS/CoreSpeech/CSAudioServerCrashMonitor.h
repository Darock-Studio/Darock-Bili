//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3302.21.3.0.0
//
#ifndef CSAudioServerCrashMonitor_h
#define CSAudioServerCrashMonitor_h
@import Foundation;

#include "CSEventMonitor.h"

@interface CSAudioServerCrashMonitor : CSEventMonitor

@property (nonatomic) unsigned long long serverState;

/* class methods */
+ (id)sharedInstance;

/* instance methods */
- (id)init;
- (void)_startMonitoringWithQueue:(id)queue;
- (void)_mediaserverdDidRestart;
- (void)_didReceiveMediaserverNotification:(unsigned long long)notification;
- (void)_notifyObserver:(id)observer withMediaserverState:(unsigned long long)state;
@end

#endif /* CSAudioServerCrashMonitor_h */