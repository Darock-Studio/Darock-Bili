//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1552.3.6.1.1
//
#ifndef PKPGSVTransitionInterstitialView_h
#define PKPGSVTransitionInterstitialView_h
@import Foundation;

#include "UIView.h"
#include "PKPGSVTransitionInterstitialItem.h"
#include "PKPGSVTransitionInterstitialSnapshotContainerView.h"

@class NSMutableArray, UIImageView;
@protocol PKSpringAnimationFactory;

@interface PKPGSVTransitionInterstitialView : UIView {
  /* instance variables */
  BOOL _blur;
  BOOL _animated;
  BOOL _transferring;
  BOOL _hasPosition;
  BOOL _active;
  BOOL _invalidated;
  unsigned long long _animationCounter;
  NSObject<PKSpringAnimationFactory> *_springFactory;
  NSObject<PKSpringAnimationFactory> *_dismissalSpringFactory;
  id /* block */ _activation;
  PKPGSVTransitionInterstitialItem *_currentItem;
  PKPGSVTransitionInterstitialSnapshotContainerView *_currentContainer;
  UIImageView *_currentSnapshot;
  id /* block */ _currentSnapshotCompletion;
  PKPGSVTransitionInterstitialItem *_previousItem;
  PKPGSVTransitionInterstitialSnapshotContainerView *_previousContainer;
  UIImageView *_previousSnapshot;
  id /* block */ _previousSnapshotCompletion;
  NSMutableArray *_obsoleteContainers;
  NSMutableArray *_obsoleteSnapshots;
  NSMutableArray *_obsoleteCompletions;
}

/* instance methods */
- (id)init;
- (id)initWithFrame:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })frame;
- (void)dealloc;
- (void)setAnchorPoint:(struct CGPoint { double x0; double x1; })point;
- (id)hitTest:(struct CGPoint { double x0; double x1; })test withEvent:(id)event;
- (void)willMoveToSuperview:(id)superview;
- (void)layoutSubviews;
@end

#endif /* PKPGSVTransitionInterstitialView_h */