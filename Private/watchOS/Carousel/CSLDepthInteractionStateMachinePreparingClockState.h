//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1112.2.15.0.0
//
#ifndef CSLDepthInteractionStateMachinePreparingClockState_h
#define CSLDepthInteractionStateMachinePreparingClockState_h
@import Foundation;

#include "CSLDepthInteractionStateMachineState.h"

@interface CSLDepthInteractionStateMachinePreparingClockState : CSLDepthInteractionStateMachineState
/* instance methods */
- (void)didEnterWithPreviousState:(id)state;
- (void)depthSessionStarted:(id)started;
- (void)context:(id)context didUpdateFromForegroundState:(id)state toState:(id)state;
- (void)context:(id)context didUpdateFromAutoLaunchOperationState:(long long)state toState:(long long)state;
- (void)context:(id)context didUpdateFromWaterLockEnabled:(BOOL)enabled toWaterLockEnabled:(BOOL)enabled;
- (long long)mode;
- (BOOL)isTransitionState;
- (long long)depthInteractionState;
- (id)targetStateForSubmersionState:(long long)state;
@end

#endif /* CSLDepthInteractionStateMachinePreparingClockState_h */