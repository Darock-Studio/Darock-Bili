//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1112.2.15.0.0
//
#ifndef CSLDepthInteractionStateMachineResettingState_h
#define CSLDepthInteractionStateMachineResettingState_h
@import Foundation;

#include "CSLDepthInteractionStateMachineState.h"

@interface CSLDepthInteractionStateMachineResettingState : CSLDepthInteractionStateMachineState
/* instance methods */
- (void)didEnterWithPreviousState:(id)state;
- (long long)mode;
- (BOOL)isTransitionState;
@end

#endif /* CSLDepthInteractionStateMachineResettingState_h */