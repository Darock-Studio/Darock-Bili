//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1552.3.6.1.1
//
#ifndef PKSafariCardNotificationManager_h
#define PKSafariCardNotificationManager_h
@import Foundation;

#include "PKPaymentService.h"

@interface PKSafariCardNotificationManager : NSObject {
  /* instance variables */
  PKPaymentService *_paymentService;
}

/* instance methods */
- (id)init;
- (void)userDidPerformAction:(long long)action withCard:(id)card;
- (void)_eligibleToCheckWithCompletion:(id /* block */)completion;
@end

#endif /* PKSafariCardNotificationManager_h */