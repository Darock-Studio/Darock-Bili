//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1262.300.81.4.10
//
#ifndef PUICQuickboardLanguageControllerDelegate_Protocol_h
#define PUICQuickboardLanguageControllerDelegate_Protocol_h
@import Foundation;

@protocol PUICQuickboardLanguageControllerDelegate 
/* instance methods */
- (void)languageControllerDidChangePrimaryLanguage:(id)language;
@optional
/* instance methods */
- (void)languageControllerDidChangePrimaryDictationLanguage:(id)language;
- (void)languageControllerDidCancelLanguageSelection:(id)selection;
- (void)languageControllerDidCancelDictationLanguageSelection:(id)selection;
@end

#endif /* PUICQuickboardLanguageControllerDelegate_Protocol_h */