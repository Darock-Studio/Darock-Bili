//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1814.300.81.4.2
//
#ifndef CoreTelephonyClientPNRDelegate_Protocol_h
#define CoreTelephonyClientPNRDelegate_Protocol_h
@import Foundation;

@protocol CoreTelephonyClientPNRDelegate <NSObject>
@optional
/* instance methods */
- (void)pnrRequestSent:(id)sent pnrReqData:(id)data;
- (void)pnrResponseReceived:(id)received pnrRspData:(id)data;
- (void)pnrReadyStateNotification:(id)notification regState:(BOOL)state;
- (void)context:(id)context pnrSupportChanged:(BOOL)changed;
@end

#endif /* CoreTelephonyClientPNRDelegate_Protocol_h */