//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 800.20.10.0.0
//
#ifndef WLKLocale_h
#define WLKLocale_h
@import Foundation;

@class NSLocale, NSString;

@interface WLKLocale : NSObject

@property (readonly, copy, nonatomic) NSString *displayName;
@property (readonly, copy, nonatomic) NSLocale *locale;

/* instance methods */
- (id)init;
- (id)initWithDictionary:(id)dictionary;
@end

#endif /* WLKLocale_h */