//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1112.2.15.0.0
//
#ifndef CSLEclipseManager_h
#define CSLEclipseManager_h
@import Foundation;

#include "BLSHBacklightHostObserving-Protocol.h"
#include "CSLChargingChangeObserver-Protocol.h"
#include "CSLEclipseBrightnessController.h"
#include "CSLEclipseStateMachine.h"
#include "CSLEclipseStateMachineDelegate-Protocol.h"
#include "CSLPIButtonHandlerOverride-Protocol.h"
#include "CSLSSystemStateInterface-Protocol.h"
#include "CSLSWakeGestureObserver-Protocol.h"

@class CSLPRFConcurrentObserverStore, NSString, UITapGestureRecognizer;
@protocol OS_dispatch_queue;

@interface CSLEclipseManager : NSObject<BLSHBacklightHostObserving, CSLPIButtonHandlerOverride, CSLSWakeGestureObserver, CSLEclipseStateMachineDelegate, CSLChargingChangeObserver> {
  /* instance variables */
  CSLEclipseStateMachine *_stateMachine;
  CSLEclipseBrightnessController *_brightnessController;
  BOOL _supportsRotateToWake;
  UITapGestureRecognizer *_tapGestureRecognizer;
  BOOL _registeredAsOverride;
  CSLPRFConcurrentObserverStore *_observers;
  NSObject<OS_dispatch_queue> *_calloutQueue;
  id _minorDetentAssertion;
  unsigned long long _stateHandler;
  int _notifyToken;
  NSObject<CSLSSystemStateInterface> *_theaterModeInterface;
  BOOL _alwaysOnEnabled;
}

@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)sharedInstance;

/* instance methods */
- (id)init;
- (void)dealloc;
- (struct os_state_data_s { unsigned int x0; union { unsigned int x0 :32; unsigned int x1; } x1; struct os_state_data_decoder_s { char x0[64] char x1[64] } x2; char x3[64] unsigned char x4[0] } *)_stateDataWithHints:(struct os_state_hints_s { unsigned int x0; char * x1; unsigned int x2; unsigned int x3; } *)hints;
- (void)stateMachine:(id)machine updatedToPercent:(double)percent;
- (void)stateMachineSuggestsBacklightOff:(id)off;
- (void)stateMachine:(id)machine showWindow:(BOOL)window;
- (void)stateMachine:(id)machine overrideEvents:(BOOL)events;
- (BOOL)_eclipseEnabled;
- (void)_setUpEclipseOverridesAndBehavior;
- (void)_cleanUpEclipseOverridesAndBehavior;
- (void)_deregisterForButtonHandlerOverrideIfNecessary;
- (void)_registerForButtonhandlerOverrideIfNecessary;
- (void)_disableMinorDetentsIfNecessary;
- (void)_enableMinorDetentsIfNecessary;
- (void)setEclipsePercent:(double)percent;
- (void)wakeGestureRecognized:(id)recognized;
- (void)addObserver:(id)observer;
- (void)removeObserver:(id)observer;
- (void)_notifyObservers;
- (void)backlightHost:(id)host willTransitionToState:(long long)state forEvent:(id)event;
- (void)backlight:(id)backlight didCompleteUpdateToState:(long long)state forEvent:(id)event;
- (void)backlight:(id)backlight didChangeAlwaysOnEnabled:(BOOL)enabled;
- (void)setAOTEnabled:(BOOL)aotenabled;
- (BOOL)preHandleButton:(unsigned long long)button eventType:(unsigned long long)type firstDownTime:(unsigned long long)time lastUpTime:(unsigned long long)time;
- (BOOL)postHandleButton:(unsigned long long)button eventType:(unsigned long long)type firstDownTime:(unsigned long long)time lastUpTime:(unsigned long long)time;
- (BOOL)shouldSendEvent:(id)event;
- (void)_wheelChangedWithEvent:(id)event;
- (void)theaterModeDidChange:(BOOL)change;
- (void)offCharger;
- (void)onCharger;
@end

#endif /* CSLEclipseManager_h */