//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 7209.1.301.0.0
//
#ifndef _UISearchControllerLimitedUIShieldViewController_h
#define _UISearchControllerLimitedUIShieldViewController_h
@import Foundation;

#include "UIViewController.h"
#include "_UISearchControllerLimitedAccessView.h"

@interface _UISearchControllerLimitedUIShieldViewController : UIViewController

@property (retain, nonatomic) _UISearchControllerLimitedAccessView *limitedAccessView;
@property (copy, nonatomic) id /* block */ dismissAction;

/* instance methods */
- (void)dealloc;
- (void)loadView;
- (void)_backButtonPressed:(id)pressed;
@end

#endif /* _UISearchControllerLimitedUIShieldViewController_h */