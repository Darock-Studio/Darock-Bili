//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 503.2.0.0.0
//
#ifndef STScreenTimeEnabledUserNotificationContext_h
#define STScreenTimeEnabledUserNotificationContext_h
@import Foundation;

#include "STUserNotificationContext.h"

@interface STScreenTimeEnabledUserNotificationContext : STUserNotificationContext
/* class methods */
+ (BOOL)supportsSecureCoding;

/* instance methods */
- (id)init;
- (id)initWithCoder:(id)coder;
- (void)customizeNotificationContent:(id)content withCompletionBlock:(id /* block */)block;
- (id)notificationBundleIdentifier;
@end

#endif /* STScreenTimeEnabledUserNotificationContext_h */