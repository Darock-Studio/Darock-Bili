//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 165.19.0.0.0
//
#ifndef STUIVisualProviderSettings_h
#define STUIVisualProviderSettings_h
@import Foundation;

#include "PTSettings.h"

@class NSString;

@interface STUIVisualProviderSettings : PTSettings

@property (nonatomic) BOOL redInSpringBoard;
@property (retain, nonatomic) NSString *visualProviderClassName;
@property (nonatomic) BOOL promoteThermalWarning;
@property (nonatomic) BOOL enableActivity;
@property (nonatomic) double backgroundActivityCoalescingDelay;
@property (nonatomic) BOOL showVPNDisconnect;
@property (nonatomic) BOOL legacyPhoneUsesiPadLayout;
@property (nonatomic) BOOL fullWidthBackgroundActivity;
@property (nonatomic) BOOL showsDateBeforeTime;
@property (nonatomic) BOOL hasBoldTime;

/* class methods */
+ (id)settingsControllerModule;

/* instance methods */
- (void)setDefaultValues;
@end

#endif /* STUIVisualProviderSettings_h */