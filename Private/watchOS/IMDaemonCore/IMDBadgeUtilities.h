//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1262.300.81.4.10
//
#ifndef IMDBadgeUtilities_h
#define IMDBadgeUtilities_h
@import Foundation;

#include "IMDMessageStore.h"

@class IMDefaults, UNUserNotificationCenter;

@interface IMDBadgeUtilities : NSObject

@property (nonatomic) unsigned long long unreadCount;
@property (nonatomic) long long lastFailedMessageDate;
@property (nonatomic) BOOL showingFailure;
@property (nonatomic) BOOL unexpectedlyLoggedOut;
@property (nonatomic) BOOL addedObserverForUnexpectedlyLoggedOut;
@property (retain, nonatomic) UNUserNotificationCenter *notificationCenter;
@property (retain, nonatomic) IMDefaults *sharedDefaultsInstance;
@property (weak, nonatomic) IMDMessageStore *messageStore;

/* class methods */
+ (id)sharedInstance;

/* instance methods */
- (id)init;
- (id)initWithMessageStore:(id)store;
- (id)initWithMessageStore:(id)store defaultsStore:(id)store;
- (void)dealloc;
- (void)updateBadgeForUnreadCountChangeIfNeeded:(long long)needed;
- (void)_updateBadgeAndCancelPreviousUpdate;
- (void)_updateBadge;
- (void)_postBadgeNumber:(id)number;
- (void)_postBadgeString:(id)string;
- (BOOL)_shouldShowFailureString;
- (BOOL)isInAppleStoreDemoMode;
- (BOOL)isShowingFailure;
- (BOOL)isUnexpectedlyLoggedOut;
@end

#endif /* IMDBadgeUtilities_h */