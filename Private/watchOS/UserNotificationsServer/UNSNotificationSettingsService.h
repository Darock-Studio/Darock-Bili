//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 491.7.0.0.0
//
#ifndef UNSNotificationSettingsService_h
#define UNSNotificationSettingsService_h
@import Foundation;

#include "UNSCriticalAlertAuthorizationAlertController.h"
#include "UNSNotificationAuthorizationAlertController.h"
#include "UNSNotificationRepositorySettingsProvider-Protocol.h"
#include "UNSSettingsGateway.h"
#include "UNSSettingsGatewayObserver-Protocol.h"

@class NSMutableArray, NSString;
@protocol OS_dispatch_queue;

@interface UNSNotificationSettingsService : NSObject<UNSSettingsGatewayObserver, UNSNotificationRepositorySettingsProvider> {
  /* instance variables */
  NSMutableArray *_observers;
  UNSSettingsGateway *_settingsGateway;
  UNSCriticalAlertAuthorizationAlertController *_criticalAlertAuthorizationAlertController;
  UNSNotificationAuthorizationAlertController *_notificationAuthorizationAlertController;
  NSObject<OS_dispatch_queue> *_queue;
}

@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (id)initWithSettingsGateway:(id)gateway;
- (void)dealloc;
- (void)addObserver:(id)observer;
- (void)removeObserver:(id)observer;
- (id)notificationSettingsForBundleIdentifier:(id)identifier;
- (id)notificationSettingsForTopicsWithBundleIdentifier:(id)identifier;
- (id)notificationSourceForBundleIdentifier:(id)identifier;
- (id)notificationSourcesForBundleIdentifiers:(id)identifiers;
- (id)allNotificationSources;
- (void)authorizationWithOptions:(unsigned long long)options forNotificationSourceIdentifier:(id)identifier withCompletionHandler:(id /* block */)handler;
- (void)replaceNotificationSettings:(id)settings forNotificationSourceIdentifier:(id)identifier;
- (void)replaceNotificationTopicSettings:(id)settings forNotificationSourceIdentifier:(id)identifier topicIdentifier:(id)identifier;
- (id)notificationSystemSettings;
- (void)setNotificationSystemSettings:(id)settings;
- (void)resetScheduledDeliverySetting;
- (void)_queue_addObserver:(id)observer;
- (void)_queue_removeObserver:(id)observer;
- (void)settingsGateway:(id)gateway didUpdateSectionInfoForSectionIDs:(id)ids;
- (void)settingsGateway:(id)gateway didUpdateGlobalSettings:(id)settings;
@end

#endif /* UNSNotificationSettingsService_h */