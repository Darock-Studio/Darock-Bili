//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1262.300.81.4.10
//
#ifndef UINavigationBar_CKUtilities_h
#define UINavigationBar_CKUtilities_h
@import Foundation;

@interface UINavigationBar (CKUtilities)
/* instance methods */
- (void)setDarkEffectStyle:(BOOL)style;
- (void)enableBranding:(BOOL)branding forBusinessChat:(id)chat;
- (void)enableBranding:(BOOL)branding forBusinessHandle:(id)handle;
- (void)_enableBusinessBranding:(BOOL)branding primaryColor:(id)color secondaryColor:(id)color;
@end

#endif /* UINavigationBar_CKUtilities_h */