//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 114.2.2.0.0
//
#ifndef WAGGreySession_h
#define WAGGreySession_h
@import Foundation;

#include "WAGGreySessionDelegate-Protocol.h"

@class NSDate, NSSet, SWSystemActivityAssertion;

@interface WAGGreySession : NSObject {
  /* instance variables */
  NSDate *_lastValidEventDate;
  BOOL _isCoreGestureAvailable;
  NSSet *_pendingRequests;
  SWSystemActivityAssertion *_activityAssertion;
}

@property (nonatomic) unsigned long long state;
@property (nonatomic) unsigned long long goal;
@property (weak, nonatomic) NSObject<WAGGreySessionDelegate> *delegate;
@property (retain, nonatomic) NSSet *requests;

/* instance methods */
- (id)init;
- (void)dealloc;
- (void)start;
- (void)stop;
- (void)simulateGestureType:(unsigned long long)type;
- (void)_handleSettingsDidChange;
- (void)_updateDataCollectionProfile;
- (void)_startOrStopTheServer;
- (void)_acquireActivityAssertion;
- (void)_releaseActivityAssertion;
- (void)_requestToStartGrey;
- (void)_requestToStopGrey;
- (void)_updatePendingRequestsIfPossible;
- (void)_didDetectDoublePinchWithMetadata:(id)metadata;
- (void)_handleDetectedGesture:(unsigned long long)gesture metadata:(id)metadata;
- (void)_handleDetectedGesture:(unsigned long long)gesture isSimulated:(BOOL)simulated metadata:(id)metadata;
@end

#endif /* WAGGreySession_h */