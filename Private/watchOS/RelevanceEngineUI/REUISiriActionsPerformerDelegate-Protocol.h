//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 472.0.0.0.0
//
#ifndef REUISiriActionsPerformerDelegate_Protocol_h
#define REUISiriActionsPerformerDelegate_Protocol_h
@import Foundation;

@protocol REUISiriActionsPerformerDelegate <NSObject>
/* instance methods */
- (id)siriActionsPerformerWantsAlertBackgroundImage:(id)image;
- (id)siriActionsPerformerWantsBackgroundViewToBlur:(id)blur;
- (BOOL)siriActionsPerformer:(id)performer wantsToPresentViewController:(id)controller;
- (void)siriActionsPerformerWantsToSuppressDismissal:(id)dismissal;
- (BOOL)siriActionsPerformer:(id)performer wantsToDismissViewController:(id)controller animated:(BOOL)animated completion:(id /* block */)completion;
- (void)siriActionsPerformerDidSucceed:(id)succeed;
- (void)siriActionsPerformer:(id)performer didFailWithError:(id)error;
@end

#endif /* REUISiriActionsPerformerDelegate_Protocol_h */