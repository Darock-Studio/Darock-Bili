//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 127.1.3.0.0
//
#ifndef NSCoder_AXMExtras_h
#define NSCoder_AXMExtras_h
@import Foundation;

@interface NSCoder (AXMExtras)
/* instance methods */
- (void)axmEncodeSize:(struct CGSize { double x0; double x1; })size forKey:(id)key;
- (struct CGSize { double x0; double x1; })axmDecodeSizeForKey:(id)key;
- (void)axmEncodePoint:(struct CGPoint { double x0; double x1; })point forKey:(id)key;
- (struct CGPoint { double x0; double x1; })axmDecodePointForKey:(id)key;
- (void)axmEncodeRect:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })rect forKey:(id)key;
- (struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })axmDecodeRectForKey:(id)key;
@end

#endif /* NSCoder_AXMExtras_h */