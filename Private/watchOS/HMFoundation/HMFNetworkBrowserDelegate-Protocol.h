//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 767.3.3.0.0
//
#ifndef HMFNetworkBrowserDelegate_Protocol_h
#define HMFNetworkBrowserDelegate_Protocol_h
@import Foundation;

@protocol HMFNetworkBrowserDelegate <NSObject>
@optional
/* instance methods */
- (void)browser:(id)browser didStartBrowsingForServiceType:(id)type;
- (void)browser:(id)browser didStopBrowsingForServiceType:(id)type;
- (void)browser:(id)browser didFindNetworkService:(id)service;
- (void)browser:(id)browser didLoseNetworkService:(id)service;
- (void)browser:(id)browser didUpdateNetworkService:(id)service;
@end

#endif /* HMFNetworkBrowserDelegate_Protocol_h */