//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 138.2.0.0.0
//
#ifndef FCMoveModeCoordinator_h
#define FCMoveModeCoordinator_h
@import Foundation;

#include "FCMoveModeCoordinatorDelegate-Protocol.h"
#include "HDDataObserver-Protocol.h"
#include "HDDatabaseProtectedDataObserver-Protocol.h"
#include "HDProfileReadyObserver-Protocol.h"

@class FCCDateProvider, HDKeyValueDomain, HDProfile, HKCategorySample, NSDateComponents, NSString;
@protocol OS_dispatch_queue;

@interface FCMoveModeCoordinator : NSObject<HDProfileReadyObserver, HDDatabaseProtectedDataObserver, HDDataObserver> {
  /* instance variables */
  HDProfile *_profile;
  NSObject<OS_dispatch_queue> *_serviceQueue;
  NSDateComponents *_birthDateComponents;
  HKCategorySample *_mostRecentActivityMoveModeChangeSample;
  BOOL _isWheelchairUser;
  HDKeyValueDomain *_keyValueDomain;
  FCCDateProvider *_dateProvider;
}

@property (weak, nonatomic) NSObject<FCMoveModeCoordinatorDelegate> *delegate;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (id)initWithDateProvider:(id)provider profile:(id)profile serviceQueue:(id)queue;
- (void)notificationPosted:(id)posted error:(id)error;
- (void)dealloc;
- (void)profileDidBecomeReady:(id)ready;
- (void)database:(id)database protectedDataDidBecomeAvailable:(BOOL)available;
- (void)samplesAdded:(id)added anchor:(id)anchor;
- (BOOL)_queue_loadBirthDateComponents;
- (BOOL)_queue_loadMoveModeChangeSample;
- (void)_saveMoveModeChangeSampleForActivityMoveMode:(long long)mode date:(id)date;
- (BOOL)_queue_loadWheelchairUse;
- (void)_queue_scheduleNotificationIfNeeded;
- (long long)_queue_determineActivityMoveModeNotificationType;
- (long long)_nextActivityMoveModeForNotificationType:(long long)type;
- (id)_nextActivityMoveModeStartDateForNotificationType:(long long)type;
- (double)_delay;
- (void)_userCharacteristicsDidChange;
- (void)_significantTimeChangeOccurred;
- (id)_lastGraduationNotificationDate;
- (void)_setLastGraduationNotificationDate:(id)date;
- (id)_upgradeToMoveTimeNotificationDate;
- (void)_setUpgradeToMoveTimeNotificationDate:(id)date;
- (id)_lastModeChangeNotificationDate;
- (void)_setLastModeChangeNotificationDate:(id)date;
- (id)_lastWheelchairModeChangeNotificationDate;
- (void)_setLastWheelchairModeChangeNotificationDate:(id)date;
- (id)_dateForKey:(id)key;
- (void)_setDate:(id)date forKey:(id)key;
- (id)keyValueDomain;
- (id)_dateByAddingNumberOfWeeks:(long long)weeks toDate:(id)date;
- (id)_tuesdayBeforeDate:(id)date;
- (id)_tuesdayAfterDate:(id)date;
- (id)_birthdayForAge:(long long)age;
- (void)_setBirthDateComponents:(id)components;
- (void)_setMostRecentActivityMoveModeChangeSample:(id)sample;
- (void)_setisWheelchairUser:(BOOL)user;
@end

#endif /* FCMoveModeCoordinator_h */