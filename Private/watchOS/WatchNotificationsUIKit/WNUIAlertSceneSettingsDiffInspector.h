//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 45.2.1.0.0
//
#ifndef WNUIAlertSceneSettingsDiffInspector_h
#define WNUIAlertSceneSettingsDiffInspector_h
@import Foundation;

#include "UIApplicationSceneSettingsDiffInspector.h"

@interface WNUIAlertSceneSettingsDiffInspector : UIApplicationSceneSettingsDiffInspector
/* instance methods */
- (void)observeActivationStateWithBlock:(id /* block */)block;
- (void)observeIsSuppressedWithBlock:(id /* block */)block;
- (void)observeIsScreenOnWithBlock:(id /* block */)block;
- (void)observeIsAlertOccludedWithBlock:(id /* block */)block;
@end

#endif /* WNUIAlertSceneSettingsDiffInspector_h */