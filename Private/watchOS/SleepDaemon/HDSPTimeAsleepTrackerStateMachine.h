//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 4146.2.12.2.2
//
#ifndef HDSPTimeAsleepTrackerStateMachine_h
#define HDSPTimeAsleepTrackerStateMachine_h
@import Foundation;

#include "HKSPPersistentStateMachine.h"
#include "HDSPTimeAsleepTrackerActivityAfterWakeUpTrackingState.h"
#include "HDSPTimeAsleepTrackerActivityTrackingState.h"
#include "HDSPTimeAsleepTrackerAutoTrackingState.h"
#include "HDSPTimeAsleepTrackerDisabledState.h"
#include "HDSPTimeAsleepTrackerInternalEndState.h"
#include "HDSPTimeAsleepTrackerManualTrackingState.h"
#include "HDSPTimeAsleepTrackerStateMachineDelegate-Protocol.h"
#include "HDSPTimeAsleepTrackerStateMachineEventHandler-Protocol.h"
#include "HDSPTimeAsleepTrackerStateMachineInfoProvider-Protocol.h"
#include "HDSPTimeAsleepTrackerWaitingState.h"

@class HKSPSleepScheduleModel, NSDate, NSString;
@protocol NAScheduler;

@interface HDSPTimeAsleepTrackerStateMachine : HKSPPersistentStateMachine<HDSPTimeAsleepTrackerStateMachineDelegate, HDSPTimeAsleepTrackerStateMachineInfoProvider, HDSPTimeAsleepTrackerStateMachineEventHandler>

@property (readonly, weak, @dynamic, nonatomic) NSObject<HDSPTimeAsleepTrackerStateMachineDelegate> *delegate;
@property (readonly, weak, @dynamic, nonatomic) NSObject<HDSPTimeAsleepTrackerStateMachineInfoProvider> *infoProvider;
@property (readonly, nonatomic) HDSPTimeAsleepTrackerDisabledState *disabledState;
@property (readonly, nonatomic) HDSPTimeAsleepTrackerWaitingState *waitingState;
@property (readonly, nonatomic) HDSPTimeAsleepTrackerAutoTrackingState *autoTrackingState;
@property (readonly, nonatomic) HDSPTimeAsleepTrackerActivityTrackingState *activityTrackingState;
@property (readonly, nonatomic) HDSPTimeAsleepTrackerActivityAfterWakeUpTrackingState *activityAfterWakeUpTrackingState;
@property (readonly, nonatomic) HDSPTimeAsleepTrackerManualTrackingState *manualTrackingState;
@property (readonly, nonatomic) HDSPTimeAsleepTrackerInternalEndState *internalEndState;
@property (readonly, nonatomic) NSObject<NAScheduler> *callbackScheduler;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;
@property (readonly, nonatomic) NSDate *currentDate;
@property (readonly, nonatomic) HKSPSleepScheduleModel *sleepScheduleModel;
@property (readonly, nonatomic) BOOL isCharging;
@property (readonly, nonatomic) BOOL isWristDetectEnabled;
@property (readonly, nonatomic) BOOL inUnscheduledSleepMode;
@property (readonly, nonatomic) BOOL inWakeDetectionWindow;
@property (readonly, nonatomic) unsigned long long sleepScheduleState;

/* instance methods */
- (id)initWithIdentifier:(id)identifier persistence:(id)persistence delegate:(id)delegate infoProvider:(id)provider currentDateProvider:(id /* block */)provider;
- (id)allStates;
- (unsigned long long)loggingCategory;
- (void)bedtimeOccurred;
- (void)wakeUpOccurredWithReason:(unsigned long long)reason;
- (void)userEngagedSleepMode;
- (void)sleepModeExitedWithReason:(unsigned long long)reason;
- (void)startWakeDetectionOccurred;
- (void)activityDetectedOnDate:(id)date;
- (void)appLaunchedOnDate:(id)date;
- (void)sleepSessionEndRequestedInternally;
- (void)sleepSessionFinished;
- (void)scheduleModelChanged:(id)changed;
- (void)startSleepTrackingSessionWithReason:(unsigned long long)reason;
- (void)endSleepTrackingSessionWithReason:(unsigned long long)reason;
- (void)startActivityDetection;
- (void)stopActivityDetection;
- (void)startAppLaunchDetection;
- (void)stopAppLaunchDetection;
- (void)notifyForActivityDetectedOnDate:(id)date;
- (id)trackingWindowAfterDate:(id)date;
@end

#endif /* HDSPTimeAsleepTrackerStateMachine_h */