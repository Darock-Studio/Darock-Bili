//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 4023.330.3.0.0
//
#ifndef MPCVocalAttenuationThermalPressurePolicy_h
#define MPCVocalAttenuationThermalPressurePolicy_h
@import Foundation;

#include "ICEnvironmentMonitorObserver-Protocol.h"
#include "MPCVocalAttenuationPolicy-Protocol.h"
#include "MPCVocalAttenuationPolicyDelegate-Protocol.h"

@class ICEnvironmentMonitor, NSString;
@protocol OS_dispatch_queue;

@interface MPCVocalAttenuationThermalPressurePolicy : NSObject<ICEnvironmentMonitorObserver, MPCVocalAttenuationPolicy>

@property (retain, nonatomic) ICEnvironmentMonitor *thermalMonitor;
@property (nonatomic) long long currentThermalLevel;
@property (nonatomic) long long cutoffThermalLevel;
@property (nonatomic) long long reenablementThermalLevel;
@property (retain, nonatomic) NSObject<OS_dispatch_queue> *calloutQueue;
@property (readonly, nonatomic) struct os_unfair_lock_s { unsigned int x0; } dataLock;
@property (nonatomic) BOOL disableVocalAttenuation;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;
@property (readonly, nonatomic) long long type;
@property (readonly, weak, nonatomic) NSObject<MPCVocalAttenuationPolicyDelegate> *delegate;
@property (readonly, nonatomic) BOOL canBeReset;

/* instance methods */
- (id)initWithCalloutQueue:(id)queue delegate:(id)delegate;
- (id)initWithThermalMonitor:(id)monitor calloutQueue:(id)queue delegate:(id)delegate;
- (void)reset;
- (id)evaluation;
- (void)environmentMonitorDidChangeThermalLevel:(id)level;
- (void)thermalStateDidChange:(long long)change;
- (void)updateEvaluationWithReason:(id)reason;
- (BOOL)shouldDisableVocalAttenuation;
@end

#endif /* MPCVocalAttenuationThermalPressurePolicy_h */