//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3.2.4.0.0
//
#ifndef BLSHBacklightHost_h
#define BLSHBacklightHost_h
@import Foundation;

@interface BLSHBacklightHost : NSObject
/* class methods */
+ (id)sharedTelemetrySource;
+ (void)registerSharedBacklightHost:(id)host;
+ (id)sharedBacklightHost;
+ (BOOL)checkForWatchdogDidFire:(BOOL)fire;
@end

#endif /* BLSHBacklightHost_h */