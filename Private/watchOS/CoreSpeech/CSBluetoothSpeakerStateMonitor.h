//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3302.21.3.0.0
//
#ifndef CSBluetoothSpeakerStateMonitor_h
#define CSBluetoothSpeakerStateMonitor_h
@import Foundation;

#include "CSEventMonitor.h"
#include "CSAudioServerCrashMonitorDelegate-Protocol.h"

@class NSString;
@protocol OS_dispatch_queue;

@interface CSBluetoothSpeakerStateMonitor : CSEventMonitor<CSAudioServerCrashMonitorDelegate>

@property (retain, nonatomic) NSObject<OS_dispatch_queue> *queue;
@property (nonatomic) BOOL isActive;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)sharedInstance;

/* instance methods */
- (id)init;
- (void)start;
- (void)_fetchSpeakerStateActiveInfo;
- (void)_startMonitoringWithQueue:(id)queue;
- (void)_stopMonitoring;
- (void)_didReceiveBluetoothSpeakerStateChangeNotification:(BOOL)notification;
- (void)CSAudioServerCrashMonitorDidReceiveServerRestart:(id)restart;
@end

#endif /* CSBluetoothSpeakerStateMonitor_h */