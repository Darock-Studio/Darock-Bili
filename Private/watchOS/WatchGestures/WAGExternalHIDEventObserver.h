//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 114.2.2.0.0
//
#ifndef WAGExternalHIDEventObserver_h
#define WAGExternalHIDEventObserver_h
@import Foundation;

#include "WAGBacklightStateObserver-Protocol.h"
#include "WAGExternalHIDEventDelegate-Protocol.h"

@class AWAttentionAwarenessClient, HIDEventSystemClient, NSMutableDictionary, NSString;

@interface WAGExternalHIDEventObserver : NSObject<WAGBacklightStateObserver> {
  /* instance variables */
  AWAttentionAwarenessClient *_attentionClient;
  HIDEventSystemClient *_hidEventClient;
  NSMutableDictionary *_buttonPressEventsByUsage;
  BOOL _isActive;
}

@property (weak, nonatomic) NSObject<WAGExternalHIDEventDelegate> *delegate;
@property (readonly, nonatomic) BOOL isPressingHardwareButton;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (void)dealloc;
- (void)start;
- (void)stop;
- (void)_createClientsIfNecessary;
- (void)_createAttentionClient;
- (void)_createHidEventClient;
- (void)backlightStateManager:(id)manager didUpdateScreenActive:(BOOL)active;
@end

#endif /* WAGExternalHIDEventObserver_h */