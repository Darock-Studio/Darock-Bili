//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 524.1.0.0.0
//
#ifndef RPLegacyDeviceDiscovery_h
#define RPLegacyDeviceDiscovery_h
@import Foundation;

@class CUMobileDeviceDiscovery, CUWiFiScanner, NSData, NSMutableDictionary, NSSet, NSString, SFDeviceDiscovery;
@protocol OS_dispatch_queue;

@interface RPLegacyDeviceDiscovery : NSObject {
  /* instance variables */
  BOOL _activateCalled;
  BOOL _activateInProgress;
  BOOL _activateCompleted;
  NSData *_blePayloadFilterData;
  NSData *_blePayloadFilterMask;
  NSMutableDictionary *_devices;
  BOOL _invalidateCalled;
  BOOL _invalidateDone;
  BOOL _verifyDevices;
  SFDeviceDiscovery *_bleDiscovery;
  struct BonjourBrowser * _bonjourBrowser;
  CUMobileDeviceDiscovery *_mdDiscovery;
  BOOL _wifiAirPlayWAC;
  CUWiFiScanner *_wifiScanner;
}

@property (nonatomic) unsigned int changeFlags;
@property (nonatomic) unsigned char deviceActionType;
@property (copy, nonatomic) NSSet *deviceFilter;
@property (retain, nonatomic) NSObject<OS_dispatch_queue> *dispatchQueue;
@property (nonatomic) int rssiThreshold;
@property (nonatomic) BOOL scanCache;
@property (nonatomic) unsigned int scanRate;
@property (readonly, nonatomic) unsigned int scanState;
@property (copy, nonatomic) NSString *serviceType;
@property (nonatomic) BOOL targetUserSession;
@property (nonatomic) double timeout;
@property (nonatomic) unsigned int wifiScanFlags;
@property (copy, nonatomic) NSString *wifiSSID;
@property (copy, nonatomic) id /* block */ deviceFoundHandler;
@property (copy, nonatomic) id /* block */ deviceLostHandler;
@property (copy, nonatomic) id /* block */ deviceChangedHandler;
@property (copy, nonatomic) id /* block */ interruptionHandler;
@property (copy, nonatomic) id /* block */ invalidationHandler;
@property (copy, nonatomic) id /* block */ scanStateChangedHandler;
@property (copy, nonatomic) id /* block */ timeoutHandler;

/* instance methods */
- (id)init;
- (void)dealloc;
- (void)_cleanup;
- (id)description;
- (void)setBLEPayloadFilterData:(id)data mask:(id)mask;
- (void)activateWithCompletion:(id /* block */)completion;
- (void)_activateWithCompletion:(id /* block */)completion;
- (void)_interrupted;
- (void)invalidate;
- (void)_invalidate;
- (void)_invalidated;
- (void)_foundDevice:(id)device;
- (void)_lostDeviceByIdentifier:(id)identifier;
- (void)_lostAllDevices;
- (int)_bleStart;
- (void)_bleHandleDeviceFound:(id)found;
- (void)_bleHandleDeviceLost:(id)lost;
- (void)_bleHandleDeviceChanged:(id)changed changes:(unsigned int)changes;
- (int)_bonjourStart;
- (void)_bonjourHandleEventType:(unsigned int)type info:(id)info;
- (void)_bonjourHandleAddOrUpdateDevice:(id)device;
- (void)_bonjourHandleRemoveDevice:(id)device;
- (int)_mdStart;
- (void)_mdHandleDeviceFound:(id)found;
- (void)_mdHandleDeviceLost:(id)lost;
- (void)_mdHandleDeviceChanged:(id)changed changes:(unsigned int)changes;
- (int)_wifiStart;
- (void)_wifiHandleDeviceFound:(id)found;
- (void)_wifiHandleDeviceLost:(id)lost;
- (void)_wifiHandleDeviceChanged:(id)changed changes:(unsigned int)changes;
@end

#endif /* RPLegacyDeviceDiscovery_h */