//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 7209.1.301.0.0
//
#ifndef _UIStatusBarVisualProvider_iOS_h
#define _UIStatusBarVisualProvider_iOS_h
@import Foundation;

#include "_UIStatusBar.h"
#include "_UIStatusBarDisplayItemPlacement.h"
#include "_UIStatusBarDisplayItemPlacementGroup.h"
#include "_UIStatusBarDisplayItemPlacementNetworkGroup.h"
#include "_UIStatusBarVisualProvider-Protocol.h"

@class NSArray, NSString, UIFont;

@interface _UIStatusBarVisualProvider_iOS : NSObject<_UIStatusBarVisualProvider>

@property (retain, nonatomic) _UIStatusBarDisplayItemPlacementGroup *secondaryWifiGroup;
@property (readonly) BOOL hasCellularCapability;
@property (readonly) BOOL wantsExpandedLeadingPlacements;
@property (readonly) BOOL wantsPillInExpandedTrailingPlacements;
@property (readonly) double leadingItemSpacing;
@property (readonly) double itemSpacing;
@property (readonly) double expandedItemSpacing;
@property (readonly) double regionSpacing;
@property (readonly) double bluetoothPaddingInset;
@property (nonatomic) BOOL expanded;
@property (nonatomic) BOOL onLockScreen;
@property (readonly, nonatomic) _UIStatusBarDisplayItemPlacementNetworkGroup *expandedNetworkGroup;
@property (readonly, nonatomic) NSArray *expandedCellularPlacementsAffectedByAirplaneMode;
@property (readonly, nonatomic) NSArray *expandedLeadingPlacements;
@property (readonly, nonatomic) NSArray *expandedTrailingPlacements;
@property (readonly, nonatomic) _UIStatusBarDisplayItemPlacement *expandedPillPlacement;
@property (readonly, nonatomic) _UIStatusBarAnimation *animationForAirplaneMode;
@property (readonly, nonatomic) double airplaneObstacleFadeOutDuration;
@property (readonly, nonatomic) double airplaneObstacleFadeInDuration;
@property (readonly, nonatomic) _UIStatusBarAnimation *animationForProminentLocation;
@property (weak, nonatomic) _UIStatusBar *statusBar;
@property (readonly, nonatomic) UIFont *clockFont;
@property (readonly, nonatomic) BOOL canFixupDisplayItemAttributes;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (Class)visualProviderSubclassForScreen:(id)screen visualProviderInfo:(id)info;
+ (BOOL)scalesWithScreenNativeScale;
+ (BOOL)requiresIterativeOverflowLayout;
+ (double)height;
+ (double)cornerRadius;
+ (struct CGSize { double x0; double x1; })intrinsicContentSizeForOrientation:(long long)orientation;

/* instance methods */
- (BOOL)wantsBackgroundActivityPillInExpandedTrailingPlacements;
- (id)init;
- (id)styleAttributesForStyle:(long long)style;
- (id)orderedDisplayItemPlacementsInRegionWithIdentifier:(id)identifier;
- (id)setupInContainerView:(id)view;
- (void)modeUpdatedFromMode:(long long)mode;
- (void)actionable:(id)actionable highlighted:(BOOL)highlighted initialPress:(BOOL)press;
- (void)_createExpandedPlacements;
- (id)willUpdateWithData:(id)data;
- (void)updateDataForService:(id)service;
- (id)displayItemIdentifiersForPartWithIdentifier:(id)identifier;
- (void)_applyToAppearingRegions:(BOOL)regions block:(id /* block */)block;
- (BOOL)hasCustomAnimationForDisplayItemWithIdentifier:(id)identifier removal:(BOOL)removal;
- (id)additionAnimationForDisplayItemWithIdentifier:(id)identifier itemAnimation:(id)animation;
- (id)removalAnimationForDisplayItemWithIdentifier:(id)identifier itemAnimation:(id)animation;
- (void)updateDataForSystemNavigation:(id)navigation;
- (double)airplaneTravelOffsetInProposedPartWithIdentifier:(id *)identifier animationType:(long long)type;
- (double)airplaneSpeedForAnimationType:(long long)type;
- (double)airplaneShouldFadeForAnimationType:(long long)type;
- (id)defaultAnimationForDisplayItemWithIdentifier:(id)identifier;
@end

#endif /* _UIStatusBarVisualProvider_iOS_h */