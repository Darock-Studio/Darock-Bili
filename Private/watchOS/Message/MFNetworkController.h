//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3774.300.42.0.0
//
#ifndef MFNetworkController_h
#define MFNetworkController_h
@import Foundation;

#include "CXCallObserverDelegate-Protocol.h"
#include "EFCancelable-Protocol.h"
#include "RadiosPreferencesDelegate-Protocol.h"

@class AWDMailNetworkDiagnosticsReport, CXCallObserver, CoreTelephonyClient, EFObservable, MFLock, NSString, RadiosPreferences;
@protocol OS_dispatch_queue;

@interface MFNetworkController : NSObject<RadiosPreferencesDelegate, CXCallObserverDelegate> {
  /* instance variables */
  NSObject<EFCancelable> *_stateCancelable;
  struct __SCNetworkReachability * _reachability;
  struct __SCDynamicStore * _store;
  struct __CFRunLoopSource * _store_source;
  CXCallObserver *_callObserver;
  MFLock *_lock;
  struct __CFRunLoop * _rl;
  unsigned int _flags;
  BOOL _hasDNS;
  unsigned long long _activeCalls;
  struct __SCPreferences * _wiFiPreferences;
  BOOL _hasCellDataCapability;
  BOOL _hasWiFiCapability;
  BOOL _isWiFiEnabled;
  BOOL _isRoamingAllowed;
  RadiosPreferences *_radiosPreferences;
  NSObject<OS_dispatch_queue> *_prefsQueue;
  int _symptomsToken;
  CoreTelephonyClient *_ctc;
  NSObject<OS_dispatch_queue> *_dataStatusQueue;
  BOOL _cellularDataAvailable;
  struct os_unfair_lock_s { unsigned int _os_unfair_lock_opaque; } _dataStatusInitializerLock;
  BOOL _dataStatusInitialized;
  BOOL _callObserverInitialized;
}

@property (readonly) BOOL isDataAvailable;
@property (readonly) BOOL isNetworkUp;
@property (readonly) BOOL isFatPipe;
@property (readonly) BOOL isOnWWAN;
@property (readonly) BOOL inAirplaneMode;
@property (readonly) BOOL is3GConnection;
@property (readonly) BOOL is4GConnection;
@property (readonly) int dataIndicator;
@property (readonly) long long transportType;
@property (readonly, nonatomic) EFObservable *networkObservable;
@property (readonly, nonatomic) EFObservable *wifiObservable;
@property (readonly, nonatomic) AWDMailNetworkDiagnosticsReport *awdNetworkDiagnosticReport;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)signpostLog;
+ (id)sharedInstance;
+ (id)observers;
+ (void)performExecuteOnObservers;
+ (id)networkAssertionWithIdentifier:(id)identifier;
+ (id)addNetworkObserverBlock:(id /* block */)block queue:(id)queue;
+ (void)removeNetworkObserver:(id)observer;

/* instance methods */
- (unsigned long long)signpostID;
- (id)init;
- (void)_initializeDataStatus;
- (void)_resetDataStatusInitialized;
- (void)_setupSymptoms;
- (void)dealloc;
- (BOOL)_simulationOverrideForType:(unsigned long long)type actualValue:(BOOL)value;
- (void)_setDataStatus_nts:(id)status_nts;
- (int)dataStatus;
- (BOOL)_isNetworkUp_nts;
- (void)_setFlags:(unsigned int)flags forReachability:(struct __SCNetworkReachability *)reachability;
- (void)_checkKeys:(id)keys forStore:(struct __SCDynamicStore *)store;
- (void)_handleWiFiNotification:(unsigned int)notification;
- (id)_networkAssertionWithIdentifier:(id)identifier;
- (id)copyCarrierBundleValue:(id)value;
- (void)_carrierBundleDidChange;
- (void)connectionActivationError:(id)error connection:(int)connection error:(int)error;
- (void)preferredDataSimChanged:(id)changed;
- (void)dataStatus:(id)status dataStatusInfo:(id)info;
- (void)simStatusDidChange:(id)change status:(id)status;
- (void)_updateActiveCalls;
- (void)callObserver:(id)observer callChanged:(id)changed;
- (void)airplaneModeChanged;
- (void)_registerStateCaptureHandler;
@end

#endif /* MFNetworkController_h */