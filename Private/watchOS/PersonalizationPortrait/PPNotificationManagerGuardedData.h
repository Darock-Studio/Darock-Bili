//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1226.2.2.1.0
//
#ifndef PPNotificationManagerGuardedData_h
#define PPNotificationManagerGuardedData_h
@import Foundation;

#include "PPNotificationHandler.h"

@class CNContactStore, EKCalendarVisibilityManager, EKEventStore;
@protocol NSObject;

@interface PPNotificationManagerGuardedData : NSObject {
  /* instance variables */
  PPNotificationHandler *_contactsHandler;
  NSObject<NSObject> *_contactsToken;
  CNContactStore *_cnStore;
  PPNotificationHandler *_meCardHandler;
  NSObject<NSObject> *_meCardToken;
  NSObject<NSObject> *_meCardDonationToken;
  PPNotificationHandler *_portraitChangeHandler;
  int _portraitChangeToken;
  PPNotificationHandler *_portraitInvalidationHandler;
  int _portraitInvalidationToken;
  PPNotificationHandler *_eventKitHandler;
  NSObject<NSObject> *_eventKitToken;
  EKEventStore *_ekStore;
  PPNotificationHandler *_calendarHandler;
  EKCalendarVisibilityManager *_calendarVisibilityManager;
}

/* instance methods */
- (id)description;
@end

#endif /* PPNotificationManagerGuardedData_h */