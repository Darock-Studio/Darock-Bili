//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1092.3.10.0.0
//
#ifndef HMDUIDialogPresenter_h
#define HMDUIDialogPresenter_h
@import Foundation;

#include "HMFObject.h"

@class BOOL *, NSMutableArray;
@protocol OS_dispatch_queue, OS_dispatch_semaphore;

@interface HMDUIDialogPresenter : HMFObject

@property (retain, nonatomic) NSObject<OS_dispatch_queue> *workQueue;
@property (nonatomic) struct __CFUserNotification * currentNotification;
@property (retain, nonatomic) id currentContext;
@property (retain, nonatomic) NSMutableArray *pendingContexts;
@property (nonatomic) BOOL selectedByPeerDevice;
@property (nonatomic) BOOL peerDeviceAcceptedSelection;
@property (retain, nonatomic) NSObject<OS_dispatch_semaphore> *notificationSem;
@property (readonly, nonatomic) BOOL shouldSkipAuthPromptDialog;

/* class methods */
+ (id)sharedUIDialogPresenter;

/* instance methods */
- (id)init;
- (void)dealloc;
- (void)dismissPendingDialogWithContext:(id)context queue:(id)queue completionHandler:(id /* block */)handler;
- (void)dismissPendingDialogDueToPeerDeviceSelection:(BOOL)selection context:(id)context queue:(id)queue completionHandler:(id /* block */)handler;
- (BOOL)_isPendingContext:(id)context;
- (BOOL)_addToPendingContext:(id)context;
- (BOOL)_addCurrentNotification:(struct __CFUserNotification *)notification withContext:(id)context;
- (BOOL)_removeCurrentNotification:(struct __CFUserNotification *)notification currentSelection:(BOOL)selection selectedByPeerDevice:(BOOL *)device andContext:(id)context;
- (void)requestUserPermissionForUnauthenticatedAccessory:(id)accessory withContext:(id)context queue:(id)queue completionHandler:(id /* block */)handler;
- (void)_requestUserPermissionForUnauthenticatedAccessory:(id)accessory withContext:(id)context queue:(id)queue completionHandler:(id /* block */)handler;
- (void)requestUserPermissionForLegacyWACAccessory:(id)wacaccessory withContext:(id)context queue:(id)queue completionHandler:(id /* block */)handler;
- (void)requestUserPermissionWithAccessoryPPIDInfo:(id)ppidinfo name:(id)name category:(id)category withContext:(id)context queue:(id)queue completionHandler:(id /* block */)handler;
- (void)_requestUserPermissionWithAccessoryPPIDInfo:(id)ppidinfo name:(id)name category:(id)category withContext:(id)context queue:(id)queue completionHandler:(id /* block */)handler;
- (void)requestUserPermissionForDeletionOfHomeWithName:(id)name withContext:(id)context queue:(id)queue completionHandler:(id /* block */)handler;
- (void)_requestUserPermissionForDeletionOfHomeWithName:(id)name withContext:(id)context queue:(id)queue completionHandler:(id /* block */)handler;
- (void)requestUserPermissionForRemovalOfRouter:(id)router accessoriesRequiringManualReconfiguration:(id)reconfiguration withContext:(id)context queue:(id)queue completionHandler:(id /* block */)handler;
- (void)_requestUserPermissionForRemovalOfRouter:(id)router accessoriesRequiringManualReconfiguration:(id)reconfiguration withContext:(id)context queue:(id)queue completionHandler:(id /* block */)handler;
- (void)requestUserPermissionForRemovalOfSpecificWiFiCredentialedAccessory:(id)accessory withContext:(id)context queue:(id)queue completionHandler:(id /* block */)handler;
- (void)_requestUserPermissionForRemovalOfSpecificWiFiCredentialedAccessory:(id)accessory withContext:(id)context queue:(id)queue completionHandler:(id /* block */)handler;
- (void)showUserDialogForIncompatibleAccessory:(id)accessory name:(id)name category:(id)category withContext:(id)context queue:(id)queue completionHandler:(id /* block */)handler;
- (void)_showUserDialogForIncompatibleAccessory:(id)accessory name:(id)name category:(id)category withContext:(id)context queue:(id)queue completionHandler:(id /* block */)handler;
- (void)_requestUserPermissionForLegacyWACAccessory:(id)wacaccessory withContext:(id)context queue:(id)queue completionHandler:(id /* block */)handler;
- (void)displayKeychainSyncForHome:(id)home withContext:(id)context queue:(id)queue completionHandler:(id /* block */)handler;
- (void)_displayKeychainSyncForHome:(id)home withContext:(id)context queue:(id)queue completionHandler:(id /* block */)handler;
- (void)displayiCloudSwitchWithContext:(id)context queue:(id)queue completionHandler:(id /* block */)handler;
- (void)_displayiCloudSwitchWithContext:(id)context queue:(id)queue completionHandler:(id /* block */)handler;
- (void)displayUpgradeNeededWithContext:(id)context queue:(id)queue completionHandler:(id /* block */)handler;
- (void)_displayUpgradeNeededWithContext:(id)context queue:(id)queue completionHandler:(id /* block */)handler;
- (void)confirmReportAccessory:(id)accessory context:(id)context completionQueue:(id)queue completionHandler:(id /* block */)handler;
- (void)displayExecutionErrorOfTrigger:(id)trigger partialSuccess:(BOOL)success context:(id)context completionQueue:(id)queue completionHandler:(id /* block */)handler;
- (void)displayRestrictedBluetoothCharacteristicsWarningWithDeviceName:(id)name completionHandler:(id /* block */)handler;
- (BOOL)_presentDialogWithInfo:(id)info options:(unsigned long long)options targetResponse:(unsigned long long)response textField:(id *)field withContext:(id)context selectedByPeerDevice:(BOOL *)device timeout:(double)timeout;
- (BOOL)_presentDialogWithInfo:(id)info options:(unsigned long long)options textField:(id *)field withContext:(id)context;
- (BOOL)_presentDialogWithInfo:(id)info options:(unsigned long long)options targetResponse:(unsigned long long)response textField:(id *)field withContext:(id)context;
@end

#endif /* HMDUIDialogPresenter_h */