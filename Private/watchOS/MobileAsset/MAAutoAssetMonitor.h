//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 936.60.10.0.0
//
#ifndef MAAutoAssetMonitor_h
#define MAAutoAssetMonitor_h
@import Foundation;

#include "MAAutoAssetSelector.h"
#include "NSSecureCoding-Protocol.h"

@class NSString;
@protocol OS_dispatch_queue;

@interface MAAutoAssetMonitor : NSObject<NSSecureCoding>

@property (copy, nonatomic) id /* block */ statusChangeNotificationBlock;
@property (readonly, nonatomic) NSObject<OS_dispatch_queue> *notificationDispatchQueue;
@property (readonly, retain, nonatomic) NSString *autoAssetClientName;
@property (readonly, retain, nonatomic) MAAutoAssetSelector *assetSelector;

/* class methods */
+ (BOOL)supportsSecureCoding;
+ (id)defaultDispatchQueue;

/* instance methods */
- (id)initForClientName:(id)name forAssetSelector:(id)selector error:(id *)error notifyingStatusChanges:(id /* block */)changes;
- (id)initForClientName:(id)name forAssetSelector:(id)selector notifyingFromQueue:(id)queue error:(id *)error notifyingStatusChanges:(id /* block */)changes;
- (id)initWithCoder:(id)coder;
- (void)encodeWithCoder:(id)coder;
- (void)registerForNotifications:(id /* block */)notifications;
- (id)registerForNotificationsSync;
- (void)registerForNotifications:(id)notifications completion:(id /* block */)completion;
- (id)registerForNotificationsSync:(id)sync;
- (void)cancelRegistration:(id /* block */)registration;
- (id)cancelRegistrationSync;
- (id)description;
- (id)summary;
@end

#endif /* MAAutoAssetMonitor_h */