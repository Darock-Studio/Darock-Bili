//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1552.3.6.1.1
//
#ifndef PKPaymentAuthorizationServiceNavigationController_h
#define PKPaymentAuthorizationServiceNavigationController_h
@import Foundation;

#include "PKCompactNavigationContainedNavigationController.h"
#include "PKPaymentAuthorizationLayout.h"
#include "PKPaymentAuthorizationServiceViewController.h"
#include "UIViewControllerTransitioningDelegate-Protocol.h"

@interface PKPaymentAuthorizationServiceNavigationController : PKCompactNavigationContainedNavigationController {
  /* instance variables */
  PKPaymentAuthorizationLayout *_layout;
}

@property (retain, nonatomic) NSObject<UIViewControllerTransitioningDelegate> *paymentTransitioningDelegate;
@property (readonly, nonatomic) PKPaymentAuthorizationServiceViewController *authorizationViewController;

/* instance methods */
- (id)init;
- (id)initWithStyle:(unsigned long long)style;
- (id)initWithLayoutStyle:(long long)style paymentRequest:(id)request presenter:(id)presenter;
- (BOOL)_canShowWhileLocked;
- (void)traitCollectionDidChange:(id)change;
- (id)_backgroundColorForModalFormSheet;
@end

#endif /* PKPaymentAuthorizationServiceNavigationController_h */