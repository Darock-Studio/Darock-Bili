//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1112.2.15.0.0
//
#ifndef IOSSHLSceneManager_h
#define IOSSHLSceneManager_h
@import Foundation;

#include "BLSSceneDelegateWithActionHandlers-Protocol.h"
#include "CSLSceneDeactivationManager.h"
#include "CSLSceneReconnectionManager.h"
#include "CSLUnderLockSettingsBinder.h"
#include "FBSceneDelegate-Protocol.h"
#include "FBSceneManagerDelegate-Protocol.h"
#include "FBSceneManagerDelegate_Private-Protocol.h"
#include "FBSceneManagerObserver-Protocol.h"

@class BSCopyingCacheSet, FBSceneManager, NSHashTable, NSMapTable, NSMutableArray, NSMutableSet, NSString, PUICApplicationSceneClientSettingsDiffInspector, UIMutableTransformer;

@interface IOSSHLSceneManager : NSObject<FBSceneManagerDelegate, FBSceneManagerObserver, FBSceneManagerDelegate_Private, FBSceneDelegate, BLSSceneDelegateWithActionHandlers> {
  /* instance variables */
  FBSceneManager *_sceneManager;
  CSLSceneDeactivationManager *_sceneDeactivationManager;
  CSLSceneReconnectionManager *_sceneReconnectionManager;
  CSLUnderLockSettingsBinder *_underLockSettingsBinder;
  BSCopyingCacheSet *_externalForegroundApplicationScenes;
  BSCopyingCacheSet *_externalForegroundScenes;
  BSCopyingCacheSet *_daemonScenes;
  PUICApplicationSceneClientSettingsDiffInspector *_clientSettingsDiffInspector;
  NSMapTable *_assertionsForScene;
  NSHashTable *_foregroundApplications;
  struct os_unfair_lock_s { unsigned int _os_unfair_lock_opaque; } _foregroundApplicationsLock;
  NSMutableArray *_settingsBinders;
  NSMutableSet *_sceneIDsCreateOwnBLSHostEnvironment;
}

@property (readonly, nonatomic) UIMutableTransformer *sceneTransformer;
@property (nonatomic) BOOL underLock;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)sharedInstance;

/* instance methods */
- (id)init;
- (void)dealloc;
- (id)applicationForScene:(id)scene;
- (void)addSettingsBinder:(id)binder;
- (void)addSceneIdentifierCreatesOwnBLSHostEnvironment:(id)environment;
- (id)sceneDeactivationManager;
- (id)externalForegroundApplicationScenes;
- (id)externalForegroundScenes;
- (id)externalApplicationsWithForegroundApplicationScene;
- (id)sceneForMainUIState:(id)uistate;
- (id)sceneReconnectionManager;
- (void)addApplicationForScene:(id)scene;
- (void)removeApplicationForScene:(id)scene;
- (id)_assertionsForScene:(id)scene;
- (id)_clientSettingsDiffInspector;
- (id)_getApplicationBundleIdentifierFromSceneSettings:(id)settings;
- (BOOL)_shouldBecomeDelegateForScene:(id)scene;
- (BOOL)_shouldBecomeObserverForScene:(id)scene;
- (BOOL)_shouldCreateBLSHostEnvironmentForScene:(id)scene;
- (BOOL)isExternalScene:(id)scene;
- (void)sceneManager:(id)manager clientDidConnectWithHandshake:(id)handshake;
- (void)sceneManager:(id)manager interceptUpdateForScene:(id)scene withNewSettings:(id)settings;
- (void)sceneManager:(id)manager didAddScene:(id)scene;
- (void)sceneManager:(id)manager willRemoveScene:(id)scene;
- (void)_handleActiveScene:(id)scene;
- (void)_handleUpdateForScene:(id)scene withSettings:(id)settings;
- (void)_updateStateForScene:(id)scene withSettings:(id)settings;
- (void)setEffectivelyForeground:(BOOL)foreground forClockScene:(id)scene;
- (BOOL)_handleAction:(id)action forScene:(id)scene;
- (void)scene:(id)scene didReceiveActions:(id)actions;
- (void)sceneDidActivate:(id)activate;
- (void)scene:(id)scene didPrepareUpdateWithContext:(id)context;
- (void)scene:(id)scene didUpdateClientSettingsWithDiff:(id)diff oldClientSettings:(id)settings transitionContext:(id)context;
- (void)sceneDidInvalidate:(id)invalidate;
- (BOOL)_shouldTrackSceneDeactivationForScene:(id)scene;
- (void)addActionHandler:(id)handler forScene:(id)scene;
- (void)removeActionHandler:(id)handler forScene:(id)scene;
- (BOOL)isUnderLock;
@end

#endif /* IOSSHLSceneManager_h */