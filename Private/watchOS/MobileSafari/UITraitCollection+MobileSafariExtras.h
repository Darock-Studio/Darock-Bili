//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 617.1.17.12.4
//
#ifndef UITraitCollection_MobileSafariExtras_h
#define UITraitCollection_MobileSafariExtras_h
@import Foundation;

@interface UITraitCollection (MobileSafariExtras)
/* class methods */
+ (void)safari_removeAllCustomTraits:(id)traits;
+ (id)safari_traitsAffectingTextAppearance;
+ (id)safari_traitsAffectingVisualEffects;
+ (id)sf_traitCollectionUsingVibrantAppearance;

/* instance methods */
- (id)sf_alternateTintColor;
- (long long)sf_alternateUserInterfaceStyle;
- (id)sf_traitCollectionWithAlternateUserInterfaceColorAsPrimary;
- (id)sf_backgroundBlurEffect;
- (BOOL)sf_usesVibrantAppearance;
- (BOOL)sf_usesSidebarPresentation;
@end

#endif /* UITraitCollection_MobileSafariExtras_h */