//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 7209.1.301.0.0
//
#ifndef UIIndexBarView_h
#define UIIndexBarView_h
@import Foundation;

#include "UIControl.h"
#include "UIAccessibilityHUDGestureDelegate-Protocol.h"
#include "UIAccessibilityHUDGestureManager.h"
#include "UIColor.h"
#include "UIIndexBarViewDelegate-Protocol.h"
#include "UIIndexBarVisualStyle-Protocol.h"

@class NSArray, NSString;

@interface UIIndexBarView : UIControl<UIAccessibilityHUDGestureDelegate>

@property (nonatomic) double cachedDisplayHighlightedIndex;
@property (copy, nonatomic) UIColor *nonTrackingBackgroundColor;
@property (retain, nonatomic) UIAccessibilityHUDGestureManager *axHUDGestureManager;
@property (copy, nonatomic) NSArray *entries;
@property (weak, nonatomic) NSObject<UIIndexBarViewDelegate> *delegate;
@property (nonatomic) struct UIEdgeInsets { double x0; double x1; double x2; double x3; } drawingInsets;
@property (readonly, nonatomic) struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; } effectiveBounds;
@property (copy, nonatomic) UIColor *indexColor;
@property (copy, nonatomic) UIColor *trackingBackgroundColor;
@property (nonatomic) long long highlightStyle;
@property (nonatomic) double highlightedIndex;
@property (nonatomic) double deflection;
@property (retain, nonatomic) NSObject<UIIndexBarVisualStyle> *visualStyle;
@property (retain, nonatomic) NSArray *displayEntries;
@property (readonly, nonatomic) double displayHighlightedIndex;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (void)makeIndexBarView:(id *)view containerView:(id *)view forTraits:(id)traits;
+ (void)registerVisualStyle:(Class)style forIdiom:(long long)idiom;
+ (id)visualStyleForIndexBarView:(id)view;

/* instance methods */
- (id)initWithFrame:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })frame;
- (void)setFrame:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })frame;
- (void)resetDeflection:(BOOL)deflection;
- (struct CGSize { double x0; double x1; })sizeThatFits:(struct CGSize { double x0; double x1; })fits;
- (BOOL)canBecomeFocused;
- (BOOL)_defaultCanBecomeFocused;
- (void)layoutSubviews;
- (BOOL)_canDrawContent;
- (void)drawRect:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })rect;
- (void)didMoveToWindow;
- (void)_updateDisplayEntries;
- (BOOL)beginTrackingWithTouch:(id)touch withEvent:(id)event;
- (BOOL)continueTrackingWithTouch:(id)touch withEvent:(id)event;
- (void)endTrackingWithTouch:(id)touch withEvent:(id)event;
- (void)cancelTrackingWithEvent:(id)event;
- (void)touchesBegan:(id)began withEvent:(id)event;
- (void)touchesMoved:(id)moved withEvent:(id)event;
- (void)touchesEnded:(id)ended withEvent:(id)event;
- (void)_handleTouches:(id)touches withEvent:(id)event;
- (void)_updateBackgroundColor;
- (void)setBackgroundColor:(id)color;
- (id)backgroundColor;
- (void)tintColorDidChange;
- (void)_userInteractionStarted;
- (void)_userInteractionStopped;
- (BOOL)_didSelectEntry:(id)entry atIndex:(long long)index;
- (BOOL)_selectEntry:(id)entry atIndex:(long long)index;
- (void)_setupAXHUDGestureIfNecessary;
- (id)_accessibilityHUDGestureManager:(id)manager HUDItemForPoint:(struct CGPoint { double x0; double x1; })point;
- (BOOL)_accessibilityHUDGestureManager:(id)manager shouldRecognizeSimultaneouslyWithGestureRecognizer:(id)recognizer;
- (void)_accessibilityHUDGestureManager:(id)manager gestureLiftedAtPoint:(struct CGPoint { double x0; double x1; })point;
- (BOOL)_accessibilityHUDGestureManagerCancelsTouchesInView:(id)view;
@end

#endif /* UIIndexBarView_h */