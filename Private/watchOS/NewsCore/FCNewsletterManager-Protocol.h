//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 617.0.0.0.0
//
#ifndef FCNewsletterManager_Protocol_h
#define FCNewsletterManager_Protocol_h
@import Foundation;

#include "FCAppActivityObserving-Protocol.h"
#include "FCAppleAccount-Protocol.h"
#include "FCAppleAccountObserver-Protocol.h"
#include "FCBundleSubscriptionManagerType-Protocol.h"
#include "FCCKPrivateDatabase.h"
#include "FCCommandQueue.h"
#include "FCNewsAppConfigurationManager-Protocol.h"
#include "FCNewsletterEndpointConnection.h"
#include "FCNewsletterManager-Protocol.h"
#include "FCUserInfo.h"

@class NFPromise, NSDate, NSHashTable, NSString;

@protocol FCNewsletterManager <NSObject>

@property (readonly, nonatomic) BOOL enabled;
@property (readonly, nonatomic) long long activeNewsletter;
@property (readonly, nonatomic) long long subscription;
@property (readonly, nonatomic) NSString *cachedVector;
@property (readonly, nonatomic) BOOL isSubscribed;
@property (readonly, nonatomic) BOOL canSubscribe;
@property (readonly, nonatomic) BOOL canUnsubscribe;
@property (readonly, nonatomic) BOOL includeUserVector;
@property (readonly, nonatomic) BOOL includeBundleSubscribedVector;
@property (readonly, nonatomic) BOOL includeSportsVector;
@property (readonly, nonatomic) long long includeOptions;

/* instance methods */
- (long long)subscriptionStatusForNewsletter:(long long)newsletter;
- (BOOL)canSubscribeToNewsletter:(long long)newsletter;
- (BOOL)isSignedIntoEmailAccount;
- (long long)issueOptinStatus;
- (BOOL)isEligibleForIssues;
- (BOOL)isOptedIntoIssues;
- (void)subscribeFromPrivacyModalCTA;
- (void)subscribeFromPrivacyModalCTAWithCompletion:(id /* block */)completion;
- (void)unsubscribe;
- (void)optOutOfIssues;
- (void)optIntoSports;
- (void)optOutOfSports;
- (id)updateSubscription;
- (id)forceUpdateSubscription;
- (id)getWebToken;
- (void)updateCacheWithNewsletterString:(id)string includeArray:(id)array;
- (BOOL)shouldSubmitPersonalizationVector;
- (void)submitPersonalizationVector:(id)vector subscribedBundleChannelIDs:(id)ids;
- (void)deletePersonalizationVector;
- (void)addObserver:(id)observer;
- (void)removeObserver:(id)observer;
- (void)notifyObservers;
@end

#endif /* FCNewsletterManager_Protocol_h */