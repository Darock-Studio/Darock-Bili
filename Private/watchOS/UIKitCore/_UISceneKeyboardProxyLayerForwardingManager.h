//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 7209.1.301.0.0
//
#ifndef _UISceneKeyboardProxyLayerForwardingManager_h
#define _UISceneKeyboardProxyLayerForwardingManager_h
@import Foundation;

#include "_UISceneKeyboardProxyLayerForwardingPresentationEnvironmentObserver-Protocol.h"

@class NSMapTable, NSString;

@interface _UISceneKeyboardProxyLayerForwardingManager : NSObject<_UISceneKeyboardProxyLayerForwardingPresentationEnvironmentObserver> {
  /* instance variables */
  NSMapTable *_mapEnvironmentToKeyboardForwardingStateMachine;
}

@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)new;
+ (id)sharedInstance;
+ (BOOL)isRootSystemShellProcess;

/* instance methods */
- (id)init;
- (id)_init;
- (void)trackPresentationEnvironment:(id)environment;
- (id)succinctDescription;
- (id)succinctDescriptionBuilder;
- (id)descriptionWithMultilinePrefix:(id)prefix;
- (id)descriptionBuilderWithMultilinePrefix:(id)prefix;
- (void)presentationEnvironmentDidInvalidate:(id)invalidate;
- (id)_newStateMachineWithPresentationEnvironment:(id)environment;
- (id)_stateMachineForPresentationEnvironment:(id)environment;
- (void)_updateKeyboardLayersForPresentationEnvironment:(id)environment;
@end

#endif /* _UISceneKeyboardProxyLayerForwardingManager_h */