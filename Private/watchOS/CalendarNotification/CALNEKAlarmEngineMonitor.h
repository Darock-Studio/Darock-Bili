//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1502.1.1.3.0
//
#ifndef CALNEKAlarmEngineMonitor_h
#define CALNEKAlarmEngineMonitor_h
@import Foundation;

#include "CADModule-Protocol.h"
#include "CALNAlarmEngineMonitor-Protocol.h"
#include "_EKAlarmEngine.h"

@class NSNotificationCenter, NSString;

@interface CALNEKAlarmEngineMonitor : NSObject<CALNAlarmEngineMonitor, CADModule>

@property (readonly, nonatomic) NSNotificationCenter *notificationCenter;
@property (readonly, nonatomic) _EKAlarmEngine *alarmEngine;
@property (nonatomic) BOOL active;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (id)initWithAlarmEngine:(id)engine notificationCenter:(id)center;
- (void)activate;
- (void)deactivate;
- (void)receivedNotificationNamed:(id)named;
- (void)didRegisterForAlarms;
- (void)receivedAlarmNamed:(id)named;
- (void)protectedDataDidBecomeAvailable;
- (void)addAlarmsFiredObserver:(id)observer selector:(SEL)selector;
- (void)removeAlarmsFiredObserver:(id)observer;
- (BOOL)isActive;
@end

#endif /* CALNEKAlarmEngineMonitor_h */