//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 4023.330.1.0.0
//
#ifndef NSCoder_CGRectKeyedCoding_h
#define NSCoder_CGRectKeyedCoding_h
@import Foundation;

@interface NSCoder (CGRectKeyedCoding)
/* instance methods */
- (void)mr_encodeCGRect:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })cgrect forKey:(id)key;
- (struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })mr_decodeCGRectForKey:(id)key;
@end

#endif /* NSCoder_CGRectKeyedCoding_h */