//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 7209.1.301.0.0
//
#ifndef _UISearchBarAppearanceStorage_h
#define _UISearchBarAppearanceStorage_h
@import Foundation;

#include "UIImage.h"

@class NSMutableDictionary, NSValue;

@interface _UISearchBarAppearanceStorage : NSObject {
  /* instance variables */
  NSMutableDictionary *searchFieldBackgroundImages;
  NSMutableDictionary *iconImages;
}

@property (retain, nonatomic) NSValue *searchFieldPositionAdjustment;
@property (retain, nonatomic) UIImage *separatorImage;
@property (retain, nonatomic) UIImage *scopeBarBackgroundImage;

/* instance methods */
- (void)setSearchFieldBackgroundImage:(id)image forState:(unsigned long long)state;
- (id)searchFieldBackgroundImageForState:(unsigned long long)state;
- (void)setImage:(id)image forIcon:(long long)icon state:(unsigned long long)state;
- (id)imageForIcon:(long long)icon state:(unsigned long long)state;
@end

#endif /* _UISearchBarAppearanceStorage_h */