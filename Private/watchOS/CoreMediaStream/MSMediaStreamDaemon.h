//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 624.0.100.0.0
//
#ifndef MSMediaStreamDaemon_h
#define MSMediaStreamDaemon_h
@import Foundation;

#include "MSDaemon.h"

@class NSCountedSet;
@protocol MSMediaStreamDaemonDelegate;

@interface MSMediaStreamDaemon : MSDaemon {
  /* instance variables */
  NSCountedSet *_retainedObjects;
}

@property (nonatomic) NSObject<MSMediaStreamDaemonDelegate> *delegate;

/* instance methods */
- (id)init;
- (id)nextActivityDate;
- (BOOL)hasOutstandingActivity;
- (BOOL)personIDHasOutstandingPublications:(id)publications;
- (BOOL)isInRetryState;
- (void)didIdle;
- (void)didUnidle;
- (id)_boundPublisherForPersonID:(id)id;
- (id)_boundSubscriberForPersonID:(id)id;
- (id)_boundDeleterForPersonID:(id)id;
- (id)_boundServerSideConfigManagerForPersonID:(id)id;
- (void)retryOutstandingActivities;
- (void)reenqueueQuarantinedActivitiesWithReason:(id)reason;
- (void)abortAllActivityForPersonID:(id)id;
- (void)stopAllActivities;
- (void)forgetPersonID:(id)id;
- (BOOL)enqueueAssetCollection:(id)collection personID:(id)id outError:(id *)error;
- (BOOL)dequeueAssetCollectionWithGUIDs:(id)guids personID:(id)id outError:(id *)error;
- (void)pollForSubscriptionUpdatesForPersonID:(id)id;
- (void)pollForSubscriptionUpdatesTriggeredByPushNotificationForPersonID:(id)id;
- (void)resetSubscriberSyncForPersonID:(id)id;
- (void)computeHashForAsset:(id)asset personID:(id)id;
- (id)subscribedStreamsForPersonID:(id)id;
- (id)ownSubscribedStreamForPersonID:(id)id;
- (id)serverSideConfigurationForPersonID:(id)id;
- (void)didReceiveServerSideConfigurationVersion:(id)version forPersonID:(id)id;
- (void)refreshServerSideConfigurationForPersonID:(id)id;
- (void)didReceiveNewServerSideConfigurationForPersonID:(id)id;
- (void)deleteAssetCollections:(id)collections forPersonID:(id)id;
- (void)start;
- (void)stop;
- (void)didReceiveNewShareState:(id)state oldShareState:(id)state forPersonID:(id)id;
- (void)showInvitationFailureAlertForPersonID:(id)id failures:(id)failures;
- (void)didReceiveAuthenticationFailureForPersonID:(id)id;
- (void)didReceiveAuthenticationSuccessForPersonID:(id)id;
- (void)didExceedPublishQuotaForPersonID:(id)id retryDate:(id)date;
- (void)didReceiveGlobalResetSyncForPersonID:(id)id;
- (void)didReceivePushNotificationForPersonID:(id)id;
- (BOOL)mayDownloadPersonID:(id)id;
@end

#endif /* MSMediaStreamDaemon_h */