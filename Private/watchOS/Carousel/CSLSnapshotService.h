//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1112.2.15.0.0
//
#ifndef CSLSnapshotService_h
#define CSLSnapshotService_h
@import Foundation;

#include "CSLAppPrelauncher.h"
#include "CSLAppSwitcherItemPublisher.h"
#include "CSLForegroundMonitoring-Protocol.h"
#include "CSLSnapshotActivityManager.h"
#include "CSLSnapshotActivityManagerDelegate-Protocol.h"
#include "CSLSnapshotComplicationPolicy.h"
#include "CSLSnapshotContextHelper.h"
#include "CSLSnapshotServiceAppProtocol-Protocol.h"
#include "CSLSnapshotServiceEndpoint.h"
#include "CSLSnapshotServiceSystemProtocol-Protocol.h"
#include "CSLTransactionQueue.h"

@class CSLSafeMutableDictionary, NSMutableDictionary, NSString;

@interface CSLSnapshotService : NSObject<CSLSnapshotActivityManagerDelegate, CSLForegroundMonitoring, CSLSnapshotServiceAppProtocol, CSLSnapshotServiceSystemProtocol>

@property (retain, nonatomic) CSLSafeMutableDictionary *snapshotCompletionBlocks;
@property (retain, nonatomic) CSLSnapshotActivityManager *snapshotActivityManager;
@property (retain, nonatomic) CSLSnapshotServiceEndpoint *endpoint;
@property (retain, nonatomic) NSMutableDictionary *snapshotsInProgress;
@property (nonatomic) double intervalBetweenSnapshots;
@property (nonatomic) double returnToPrimaryUIInterval;
@property (nonatomic) double returnToPrimaryUILeeway;
@property (retain, nonatomic) CSLSnapshotComplicationPolicy *complicationPolicy;
@property (retain, nonatomic) CSLSnapshotContextHelper *snapshotContextHelper;
@property (retain, nonatomic) CSLAppPrelauncher *prelauncher;
@property (retain, nonatomic) CSLAppSwitcherItemPublisher *switcherItemPublisher;
@property (readonly, nonatomic) CSLTransactionQueue *snapshotQueue;
@property (readonly, nonatomic) NSMutableDictionary *transactionsInProgress;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (BOOL)isInvalidWatchKitAction:(id)action;
+ (BOOL)isWatchKitSupportUnknown:(id)unknown;
+ (id)sharedInstance;

/* instance methods */
- (void)prelaunchApp:(id)app options:(id)options completion:(id /* block */)completion;
- (void)failPrelaunchOfApp:(id)app reason:(id)reason error:(id)error;
- (void)sendSnapshotToApp:(id)app item:(id)item completion:(id /* block */)completion;
- (BOOL)isSnapshotting:(id)snapshotting;
- (void)snapshotWhenBackgroundProcessingCompletes:(id)completes completion:(id /* block */)completion;
- (void)appSnapshotted:(id)snapshotted snapshotContext:(id)context mechanism:(long long)mechanism primaryUI:(BOOL)ui;
- (void)_loadPreferences;
- (id)initWithConfiguration:(id)configuration;
- (id)init;
- (BOOL)shouldSnapshot:(id)snapshot;
- (BOOL)shouldSnapshot:(id)snapshot scheduleItem:(id)item;
- (BOOL)deductSnapshot:(id)snapshot scheduleItem:(id)item;
- (void)initiateSnapshot:(id)snapshot reason:(unsigned long long)reason item:(id)item launchIfNeeded:(BOOL)needed prelauncherOptions:(id)options completion:(id /* block */)completion;
- (void)initiateBackgroundProcessingCompleteSnapshot:(id)snapshot;
- (void)cancelBackgroundProcessingCompleteSnapshot:(id)snapshot;
- (void)_enqueueSnapshotForBundleID:(id)id reason:(unsigned long long)reason item:(id)item launchBehavior:(unsigned long long)behavior prelauncherOptions:(id)options completion:(id /* block */)completion;
- (id)trackedSnapshotActionForApp:(id)app item:(id)item responseHandler:(id /* block */)handler;
- (void)_sendSnapshotActionToApp:(id)app item:(id)item completion:(id /* block */)completion;
- (void)performSnapshotForApp:(id)app scene:(id)scene reason:(unsigned long long)reason context:(id)context completion:(id /* block */)completion;
- (void)invalidateSnapshotForBundleID:(id)id;
- (void)scheduleAppSnapshot:(id)snapshot uuid:(id)uuid date:(id)date userInfo:(id)info persist:(BOOL)persist;
- (void)processAppSnapshotItem:(id)item reason:(unsigned long long)reason forBundleID:(id)id;
- (void)scheduleSystemSnapshot:(id)snapshot forReason:(unsigned long long)reason;
- (void)registerPrivilegedSnapshotClient:(id)client priority:(unsigned long long)priority leeway:(double)leeway usesBudget:(BOOL)budget returnToPrimaryUIInterval:(double)uiinterval;
- (BOOL)snapshotActivityManager:(id)manager shouldBeginActivity:(id)activity;
- (void)foregroundMonitorService:(id)service application:(id)application changedForegroundStatus:(BOOL)status;
@end

#endif /* CSLSnapshotService_h */