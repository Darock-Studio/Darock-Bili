//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1092.3.10.0.0
//
#ifndef HAP2AccessoryServerDiscoveryBonjourLegacy_h
#define HAP2AccessoryServerDiscoveryBonjourLegacy_h
@import Foundation;

#include "HAP2LoggingObject.h"
#include "HAP2AccessoryServerDiscovery-Protocol.h"
#include "HAP2AccessoryServerDiscoveryDelegate-Protocol.h"
#include "HAP2PropertyLock.h"

@class CUBonjourBrowser, NSString;
@protocol OS_dispatch_queue;

@interface HAP2AccessoryServerDiscoveryBonjourLegacy : HAP2LoggingObject<HAP2AccessoryServerDiscovery>

@property (readonly, nonatomic) NSObject<OS_dispatch_queue> *workQueue;
@property (readonly, nonatomic) HAP2PropertyLock *propertyLock;
@property (nonatomic) BOOL discovering;
@property (readonly, nonatomic) CUBonjourBrowser *browser;
@property (readonly, nonatomic) NSObject<OS_dispatch_queue> *delegateQueue;
@property (readonly, nonatomic) NSString *type;
@property (readonly, nonatomic) NSString *domain;
@property (weak, nonatomic) NSObject<HAP2AccessoryServerDiscoveryDelegate> *delegate;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)new;

/* instance methods */
- (id)init;
- (id)initWithServiceType:(id)type domain:(id)domain;
- (id)initWithLocalDomainAndServiceType:(id)type;
- (void)dealloc;
- (BOOL)isDiscovering;
- (void)startDiscovering;
- (void)stopDiscovering;
- (void)reconfirmAccessory:(id)accessory;
- (void)_startDiscovering;
- (void)_stopDiscovering;
- (void)_reconfirmAccessory:(id)accessory;
- (void)_startBrowser;
- (void)_stopBrowser;
- (void)_handleDeviceFoundOrChanged:(id)changed;
- (void)_handleDeviceLost:(id)lost;
- (void)_handleBrowserStopped:(id)stopped;
@end

#endif /* HAP2AccessoryServerDiscoveryBonjourLegacy_h */