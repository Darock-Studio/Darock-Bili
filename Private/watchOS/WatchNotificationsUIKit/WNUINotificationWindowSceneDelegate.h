//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 45.2.1.0.0
//
#ifndef WNUINotificationWindowSceneDelegate_h
#define WNUINotificationWindowSceneDelegate_h
@import Foundation;

#include "PUICNotificationWindowSceneDelegate.h"
#include "WNUIAlertPresentationPolicyActionHandlerDelegate-Protocol.h"
#include "WNUIAnimationBSActionHandlerDelegate-Protocol.h"
#include "WNUINotificationWindowSceneManager.h"
#include "WNUIPipelineActionDispatching-Protocol.h"

@class NSString;

@interface WNUINotificationWindowSceneDelegate : PUICNotificationWindowSceneDelegate<WNUIAnimationBSActionHandlerDelegate, WNUIAlertPresentationPolicyActionHandlerDelegate>

@property (retain, nonatomic) WNUINotificationWindowSceneManager *notificationWindowSceneManager;
@property (readonly) NSObject<WNUIPipelineActionDispatching> *actionDispatcher;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (void)scene:(id)scene willConnectToSession:(id)session options:(id)options;
- (void)sceneDidDisconnect:(id)disconnect;
- (void)sceneDidBecomeActive:(id)active;
- (void)sceneWillResignActive:(id)active;
- (void)sceneWillEnterForeground:(id)foreground;
- (void)sceneDidEnterBackground:(id)background;
- (void)dismissNotificationClearingNotificationCenter:(BOOL)center;
- (void)receivePolicy:(id)policy;
@end

#endif /* WNUINotificationWindowSceneDelegate_h */