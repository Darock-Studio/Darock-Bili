//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 4146.2.12.2.2
//
#ifndef HKMCNotificationSentAnalytics_h
#define HKMCNotificationSentAnalytics_h
@import Foundation;

@interface HKMCNotificationSentAnalytics : NSObject
/* class methods */
+ (BOOL)shouldSubmit;
+ (BOOL)_isMetricEnabled;
+ (BOOL)_isAllowed;
+ (void)submitMetricForCategory:(id)category areHealthNotificationsAuthorized:(BOOL)authorized numberOfDaysShiftedForFertileWindow:(id)window numberOfDaysOffsetFromFertileWindowEnd:(id)end numberOfDaysWithWristTemp45DaysBeforeOvulationConfirmedNotification:(id)notification internalLiveOnCycleFactorOverrideEnabled:(BOOL)enabled;
+ (void)submitMetricForCategory:(id)category areHealthNotificationsAuthorized:(BOOL)authorized internalLiveOnCycleFactorOverrideEnabled:(BOOL)enabled;
@end

#endif /* HKMCNotificationSentAnalytics_h */