//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 7209.1.301.0.0
//
#ifndef _UISwipeDismissalGestureRecognizer_h
#define _UISwipeDismissalGestureRecognizer_h
@import Foundation;

#include "UIGestureRecognizer.h"

@interface _UISwipeDismissalGestureRecognizer : UIGestureRecognizer

@property (nonatomic) struct CGPoint { double x0; double x1; } originalTouchPoint;
@property (nonatomic) double allowableMovement;

/* class methods */
+ (BOOL)_shouldDefaultToTouches;

/* instance methods */
- (id)initWithTarget:(id)target action:(SEL)action;
- (void)touchesBegan:(id)began withEvent:(id)event;
- (void)touchesMoved:(id)moved withEvent:(id)event;
- (void)touchesEnded:(id)ended withEvent:(id)event;
- (void)touchesCancelled:(id)cancelled withEvent:(id)event;
- (void)reset;
@end

#endif /* _UISwipeDismissalGestureRecognizer_h */