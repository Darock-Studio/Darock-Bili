//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3.2.4.0.0
//
#ifndef BLSHBacklightStateMachineEventPerformerDelegate_Protocol_h
#define BLSHBacklightStateMachineEventPerformerDelegate_Protocol_h
@import Foundation;

@protocol BLSHBacklightStateMachineEventPerformerDelegate <NSObject>

@property (readonly, nonatomic) BOOL alwaysOnSuppressed;

/* instance methods */
- (void)eventPerformer:(id)performer didUpdateVisualContentsToBeginTransitionToState:(long long)state forEvents:(id)events abortedEvents:(id)events;
- (void)eventPerformer:(id)performer didUpdateDisplayStateForState:(long long)state forEvents:(id)events abortedEvents:(id)events;
- (BOOL)isAlwaysOnSuppressed;
@end

#endif /* BLSHBacklightStateMachineEventPerformerDelegate_Protocol_h */