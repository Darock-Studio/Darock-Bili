//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 617.1.17.12.4
//
#ifndef UIView_SafariServicesExtras_h
#define UIView_SafariServicesExtras_h
@import Foundation;

@interface UIView (SafariServicesExtras)
/* class methods */
+ (void)sf_animate:(BOOL)sf_animate usingDefaultTimingWithOptions:(unsigned long long)options animations:(id /* block */)animations completion:(id /* block */)completion;
+ (void)sf_animate:(BOOL)sf_animate usingDefaultMotionWithOptions:(unsigned long long)options animations:(id /* block */)animations completion:(id /* block */)completion;
+ (void)sf_animate:(BOOL)sf_animate usingDefaultMotionWithDelay:(double)delay options:(unsigned long long)options animations:(id /* block */)animations completion:(id /* block */)completion;
+ (void)sf_animate:(BOOL)sf_animate withDuration:(double)duration delay:(double)delay options:(unsigned long long)options animations:(id /* block */)animations completion:(id /* block */)completion;
+ (void)sf_animate:(BOOL)sf_animate usingDefaultDampedSpringWithDelay:(double)delay initialSpringVelocity:(double)velocity options:(unsigned long long)options animations:(id /* block */)animations completion:(id /* block */)completion;
+ (void)sf_animated:(BOOL)sf_animated usingFastSpringWithDelay:(double)delay options:(unsigned long long)options animations:(id /* block */)animations completion:(id /* block */)completion;
+ (void)sf_animate:(BOOL)sf_animate usingDefaultTimingWithOptions:(unsigned long long)options preferredFrameRateRange:(struct CAFrameRateRange { float x0; float x1; float x2; })range animations:(id /* block */)animations completion:(id /* block */)completion;
+ (void)sf_animateUsingDefaultDampedSpringWithDelay:(double)delay initialSpringVelocity:(double)velocity options:(unsigned long long)options preferredFrameRateRange:(struct CAFrameRateRange { float x0; float x1; float x2; })range animations:(id /* block */)animations completion:(id /* block */)completion;
+ (void)sf_animate:(BOOL)sf_animate usingDefaultDampedSpringWithDelay:(double)delay initialSpringVelocity:(double)velocity options:(unsigned long long)options preferredFrameRateRange:(struct CAFrameRateRange { float x0; float x1; float x2; })range animations:(id /* block */)animations completion:(id /* block */)completion;
+ (void)_sf_animateLinkImage:(id)image withAnimation:(long long)animation fromPoint:(struct CGPoint { double x0; double x1; })point inView:(id)view toRect:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })rect inView:(id)view afterImageDisappearsBlock:(id /* block */)block afterDestinationLayerBouncesBlock:(id /* block */)block;
+ (void)_sf_animateLinkImage:(struct CGImage *)image withAnimation:(long long)animation fromRect:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })rect inView:(id)view toRect:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })rect inView:(id)view afterImageDisappearsBlock:(id /* block */)block afterDestinationLayerBouncesBlock:(id /* block */)block;
+ (void)_sf_performLinkAnimation:(long long)animation onView:(id)view;
+ (void)_sf_cancelLinkAnimationsOnSourceWindow:(id)window destinationWindow:(id)window;

/* instance methods */
- (struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })ss_untransformedFrame;
- (void)ss_setUntransformedFrame:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })frame;
- (BOOL)_sf_isFullScreenWidth;
- (BOOL)_sf_isFullScreenHeight;
- (BOOL)_sf_usesLeftToRightLayout;
- (BOOL)_sf_hasLandscapeAspectRatio;
- (struct UIEdgeInsets { double x0; double x1; double x2; double x3; })_sf_safeAreaInsetsFlippedForLayoutDirectionality;
- (struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })_sf_safeAreaBounds;
- (struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })_sf_bottomUnsafeAreaFrame;
- (struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })_sf_bottomUnsafeAreaFrameForToolbar;
- (id)sf_privacyPreservingDescription;
- (id)_sf_viewAncestrySummaryWithMinDepth:(long long)depth paddingLevel:(long long)level;
- (id)sf_viewAncestrySummary;
- (long long)_sf_depth;
- (id)sf_commonAncestrySummaryWithView:(id)view;
- (double)_sf_convertY:(double)y toCoordinateSpace:(id)space;
- (id)_sf_snapshotImageFromIOSurface;
- (void)_sf_setOrderedSubviews:(id *)subviews count:(unsigned long long)count;
- (id)_sf_firstAncestorViewOfClass:(Class)class;
- (void)_sf_setMatchesIntrinsicContentSize;
- (void)_sf_addEdgeMatchedSubview:(id)subview;
- (void)_sf_addInteractionUnlessNil:(id)nil;
- (void)sf_applyContentSizeCategoryLimitsForToolbarButton;
@end

#endif /* UIView_SafariServicesExtras_h */