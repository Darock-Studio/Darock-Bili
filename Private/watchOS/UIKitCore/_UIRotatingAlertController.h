//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 7209.1.301.0.0
//
#ifndef _UIRotatingAlertController_h
#define _UIRotatingAlertController_h
@import Foundation;

#include "UIAlertController.h"
#include "UIPopoverPresentationControllerDelegate-Protocol.h"
#include "UIViewController.h"
#include "_UIRotatingAlertControllerDelegate-Protocol.h"

@interface _UIRotatingAlertController : UIAlertController {
  /* instance variables */
  BOOL _isRotating;
  BOOL _readyToPresentAfterRotation;
  UIViewController *_presentedViewControllerWhileRotating;
  NSObject<UIPopoverPresentationControllerDelegate> *_popoverPresentationControllerDelegateWhileRotating;
}

@property (weak, nonatomic) NSObject<_UIRotatingAlertControllerDelegate> *rotatingSheetDelegate;
@property (nonatomic) unsigned long long arrowDirections;

/* instance methods */
- (id)init;
- (void)dealloc;
- (BOOL)presentSheet;
- (BOOL)presentSheetFromRect:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })rect;
- (void)doneWithSheet;
- (void)_presentingViewControllerWillChange:(id)change;
- (void)_presentingViewControllerDidChange:(id)change;
- (BOOL)_shouldAbortAdaptationFromTraitCollection:(id)collection toTraitCollection:(id)collection withTransitionCoordinator:(id)coordinator;
- (void)willRotate:(id)rotate;
- (void)_updateSheetPositionAfterRotation;
- (void)_didRotateAndLayout;
- (void)didRotate:(id)rotate;
- (BOOL)_canShowWhileLocked;
@end

#endif /* _UIRotatingAlertController_h */