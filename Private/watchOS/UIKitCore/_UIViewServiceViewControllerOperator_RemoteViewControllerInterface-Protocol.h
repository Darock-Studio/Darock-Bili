//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 7209.1.301.0.0
//
#ifndef _UIViewServiceViewControllerOperator_RemoteViewControllerInterface_Protocol_h
#define _UIViewServiceViewControllerOperator_RemoteViewControllerInterface_Protocol_h
@import Foundation;

@protocol _UIViewServiceViewControllerOperator_RemoteViewControllerInterface <_UIViewServiceDeputy_UIViewServiceInterface, _UIViewServiceUIBehaviorInterface>
/* instance methods */
- (void)__createViewControllerWithOptions:(id)options completionBlock:(id /* block */)block;
- (void)__hostReadyToReceiveMessagesFromServiceViewController;
- (void)__hostViewWillAppear:(BOOL)appear inInterfaceOrientation:(long long)orientation traitCollection:(id)collection statusBarHeight:(double)height underlapsStatusBar:(BOOL)bar completionHandler:(id /* block */)handler;
- (void)__hostViewWillMoveToWindowInInterfaceOrientation:(long long)orientation withStatusBarHeight:(double)height underlapsStatusBar:(BOOL)bar;
- (void)__hostViewDidAppear:(BOOL)appear;
- (void)__hostViewWillDisappear:(BOOL)disappear;
- (void)__hostViewDidDisappear:(BOOL)disappear;
- (void)__hostViewDidMoveToScreenWithFBSDisplayIdentity:(id)identity newHostingHandleReplyHandler:(id /* block */)handler;
- (void)__hostDidAttachDisplay:(id)display;
- (void)__hostDidUpdateDisplay:(id)display;
- (void)__hostDidDetachDisplay:(id)display;
- (void)__hostDidUpdateSceneContext:(id)context;
- (void)__setServiceInPopover:(BOOL)popover;
- (void)__setSheetConfiguration:(id)configuration;
- (void)__sheetInteractionDraggingDidBeginWithRubberBandCoefficient:(double)coefficient;
- (void)__sheetInteractionDraggingDidChangeWithTranslation:(struct CGPoint { double x0; double x1; })translation velocity:(struct CGPoint { double x0; double x1; })velocity animateChange:(BOOL)change;
- (void)__sheetInteractionDraggingDidEnd;
- (void)__setContentSize:(struct CGSize { double x0; double x1; })size boundingPath:(id)path;
- (void)__setContentSize:(struct CGSize { double x0; double x1; })size boundingPath:(id)path withFence:(id)fence;
- (void)__setBoundingPath:(id)path;
- (void)__hostWillEnterForeground;
- (void)__hostDidEnterBackground;
- (void)__hostSceneWillEnterForeground;
- (void)__hostSceneDidEnterBackground;
- (void)__hostWillResignActive;
- (void)__hostDidBecomeActive;
- (void)__hostDidChangeStatusBarOrientationToInterfaceOrientation:(long long)orientation;
- (void)__hostDidChangeStatusBarHeight:(double)height;
- (void)__hostViewWillTransitionToSize:(struct CGSize { double x0; double x1; })size withContextDescription:(id)description boundingPath:(id)path statusBarHeight:(double)height underlapsStatusBar:(BOOL)bar fence:(id)fence timing:(struct _UIUpdateTiming { unsigned long long x0; unsigned long long x1; unsigned long long x2; })timing whenDone:(id /* block */)done;
- (void)__hostWillRotateToInterfaceOrientation:(long long)orientation duration:(double)duration skipSelf:(BOOL)self;
- (void)__hostWillAnimateRotationToInterfaceOrientation:(long long)orientation duration:(double)duration skipSelf:(BOOL)self;
- (void)__hostDidRotateFromInterfaceOrientation:(long long)orientation skipSelf:(BOOL)self;
- (void)__hostDidPromoteFirstResponder;
- (void)__hostDisablesAutomaticKeyboardBehavior:(BOOL)behavior;
- (void)__hostDidSetContentOverlayInsets:(struct UIEdgeInsets { double x0; double x1; double x2; double x3; })insets andLeftMargin:(double)margin rightMargin:(double)margin;
- (void)__hostDidSetPresentationControllerClassName:(id)name;
- (void)__setHostViewUnderlapsStatusBar:(BOOL)bar;
- (void)__scrollToTopFromTouchAtViewLocation:(struct CGPoint { double x0; double x1; })location resultHandler:(id /* block */)handler;
- (void)__hostDidUpdateAppearanceWithSerializedRepresentations:(id)representations originalSource:(id)source;
- (void)__setHostTintColor:(id)color tintAdjustmentMode:(long long)mode;
- (void)__setHostTraitCollection:(id)collection deferIfAnimated:(BOOL)animated;
- (void)__hostWillTransitionToTraitCollection:(id)collection withContextDescription:(id)description deferIfAnimated:(BOOL)animated inRemoteViewHierarchy:(BOOL)hierarchy;
- (void)__textServiceDidDismiss;
- (void)__dimmingViewWasTapped;
- (void)__exchangeAccessibilityPortInformation:(id)information replyHandler:(id /* block */)handler;
- (void)__setMediaOverridePID:(int)pid;
- (void)__setHostCanDynamicallySpecifySupportedInterfaceOrientations:(BOOL)orientations;
- (void)__saveStateForSession:(id)session restorationAnchor:(id)anchor completionHandler:(id /* block */)handler;
- (void)__restoreStateForSession:(id)session restorationAnchor:(id)anchor;
- (void)__undoActionWithToken:(long long)token;
- (void)__redoActionWithToken:(long long)token;
- (void)__cancelAlertActionWithToken:(long long)token;
- (void)__timelinesForDateInterval:(id)interval completion:(id /* block */)completion;
- (void)__updateWithFrameSpecifierDate:(id)date completion:(id /* block */)completion;
@end

#endif /* _UIViewServiceViewControllerOperator_RemoteViewControllerInterface_Protocol_h */