//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1430.300.81.0.0
//
#ifndef TPBottomSingleButtonBar_h
#define TPBottomSingleButtonBar_h
@import Foundation;

#include "TPBottomBar.h"
#include "TPButton.h"

@interface TPBottomSingleButtonBar : TPBottomBar {
  /* instance variables */
  id _delegate;
  TPButton *_button;
}

/* class methods */
+ (id)_backgroundImage;

/* instance methods */
- (double)buttonWidth;
- (void)setButton:(id)button andStyle:(BOOL)style;
- (id)button;
@end

#endif /* TPBottomSingleButtonBar_h */