//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 7209.1.301.0.0
//
#ifndef _UIBackdropContentView_h
#define _UIBackdropContentView_h
@import Foundation;

#include "UIView.h"

@interface _UIBackdropContentView : UIView {
  /* instance variables */
  BOOL _isForcingLayout;
}

/* instance methods */
- (id)initWithFrame:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })frame;
- (void)backdropView:(id)view recursivelyUpdateMaskViewsForView:(id)view;
- (void)recursivelyRemoveBackdropMaskViewsForView:(id)view;
- (void)_monitoredView:(id)view didMoveFromSuperview:(id)superview toSuperview:(id)superview;
- (void)_monitoredView:(id)view willMoveFromSuperview:(id)superview toSuperview:(id)superview;
- (void)didMoveToWindow;
@end

#endif /* _UIBackdropContentView_h */