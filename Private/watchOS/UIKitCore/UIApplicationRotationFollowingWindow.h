//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 7209.1.301.0.0
//
#ifndef UIApplicationRotationFollowingWindow_h
#define UIApplicationRotationFollowingWindow_h
@import Foundation;

#include "UIWindow.h"

@interface UIApplicationRotationFollowingWindow : UIWindow

@property (nonatomic) long long priorityLevel;
@property (nonatomic) BOOL limitToWindowLevel;

/* class methods */
+ (BOOL)_isSystemWindow;

/* instance methods */
- (void)_commonApplicationRotationFollowingWindowInit;
- (id)init;
- (id)_initWithFrame:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })frame attached:(BOOL)attached;
- (id)_initWithFrame:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })frame debugName:(id)name attached:(BOOL)attached;
- (id)_initWithFrame:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })frame debugName:(id)name scene:(id)scene attached:(BOOL)attached;
- (id)_initWithFrame:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })frame debugName:(id)name displayConfiguration:(id)configuration;
- (id)_initWithFrame:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })frame debugName:(id)name windowScene:(id)scene;
- (id)initWithWindowScene:(id)scene;
- (id)_topMostWindow;
- (void)applicationWindow:(id)window didRotateWithOrientation:(long long)orientation duration:(double)duration;
- (BOOL)_shouldAutorotateToInterfaceOrientation:(long long)orientation;
- (void)_handleStatusBarOrientationChange:(id)change;
- (BOOL)isInterfaceAutorotationDisabled;
- (BOOL)_shouldControlAutorotation;
- (id)__autorotationSanityCheckObjectFromSource:(id)source selector:(SEL)selector;
@end

#endif /* UIApplicationRotationFollowingWindow_h */