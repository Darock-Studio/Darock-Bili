//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 5.2.12.0.0
//
#ifndef AMSUIMessageMarkdownConfiguration_h
#define AMSUIMessageMarkdownConfiguration_h
@import Foundation;

@class NSParagraphStyle, UIColor, UIFont;

@interface AMSUIMessageMarkdownConfiguration : NSObject

@property (retain, nonatomic) UIColor *color;
@property (retain, nonatomic) UIFont *font;
@property (retain, nonatomic) NSParagraphStyle *paragraphStyle;
@property (retain, nonatomic) UIColor *strikeThroughColor;

/* instance methods */
- (id)initWithColor:(id)color font:(id)font;
@end

#endif /* AMSUIMessageMarkdownConfiguration_h */