//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1092.3.10.0.0
//
#ifndef HMDRemoteLoginInitiatorCompanionAuthentication_h
#define HMDRemoteLoginInitiatorCompanionAuthentication_h
@import Foundation;

#include "HMDRemoteLoginInitiatorAuthentication.h"

@class ACAccount;

@interface HMDRemoteLoginInitiatorCompanionAuthentication : HMDRemoteLoginInitiatorAuthentication

@property (readonly, nonatomic) ACAccount *account;

/* class methods */
+ (id)logCategory;

/* instance methods */
- (id)initWithSessionID:(id)id remoteDevice:(id)device workQueue:(id)queue remoteMessageSender:(id)sender delegate:(id)delegate account:(id)account;
- (void)dealloc;
- (id)description;
- (int)loginType;
- (void)authenticate;
- (void)_authenticate;
@end

#endif /* HMDRemoteLoginInitiatorCompanionAuthentication_h */