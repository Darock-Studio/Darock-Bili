//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 114.2.2.0.0
//
#ifndef WAGGestureClient_h
#define WAGGestureClient_h
@import Foundation;

#include "WAGDebuggingInformationManagerClientDelegate-Protocol.h"
#include "WAGGestureClientChannelDelegate-Protocol.h"
#include "WAGGestureClientChannelProtocol-Protocol.h"
#include "WAGGestureRecognizerDelegate-Protocol.h"
#include "WAGPClientMetadata.h"

@class NSArray, NSError, NSMutableSet, NSSet, NSString, NSTimer;
@protocol WAGGestureClientDelegate;

@interface WAGGestureClient : NSObject<WAGGestureClientChannelDelegate, WAGGestureRecognizerDelegate, WAGDebuggingInformationManagerClientDelegate> {
  /* instance variables */
  NSMutableSet *_activeRequests;
  NSObject<WAGGestureClientChannelProtocol> *_activeChannel;
  unsigned long long _communicationChannel;
  NSString *_sessionIdentifier;
  NSTimer *_timeoutTimer;
  BOOL _respondsToDidChangeToState;
  BOOL _respondsToDidReceiveActionForGestureRecognizer;
  BOOL _respondsToDidUpdateDeviceName;
}

@property (readonly, nonatomic) WAGPClientMetadata *clientMetadata;
@property (nonatomic) double timeoutInterval;
@property (readonly, copy, nonatomic) NSString *deviceName;
@property (copy, nonatomic) NSString *sceneIdentifier;
@property (copy, nonatomic) NSArray *childSceneIdentifiers;
@property (readonly, nonatomic) unsigned long long state;
@property (readonly, nonatomic) NSSet *activeRecognizers;
@property (weak, nonatomic) NSObject<WAGGestureClientDelegate> *delegate;
@property (copy, nonatomic) id /* block */ stateDidChangeBlock;
@property (readonly, nonatomic) NSError *error;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)versionDescription;

/* instance methods */
- (id)init;
- (id)initWithCommunicationChannel:(unsigned long long)channel;
- (id)initWithMetadata:(id)metadata communicationChannel:(unsigned long long)channel;
- (void)dealloc;
- (void)start;
- (void)setActiveRecognizers:(id)recognizers completionHandler:(id /* block */)handler;
- (BOOL)isRecognizerSupported:(id)supported;
- (void)stop;
- (void)_stopCurrentConnection;
- (void)_timeoutTimerDidFired;
- (void)_setActiveRecognizers:(id)recognizers completionHandler:(id /* block */)handler;
- (void)_channelDidConnect;
- (void)_updateState:(unsigned long long)state;
- (void)_reset;
- (unsigned long long)_resolvedChannel;
- (void)_handleGestureResponse:(id)response;
- (void)_updateToFailedStateWithError:(id)error;
- (void)channel:(id)channel stateChangedTo:(unsigned long long)to error:(id)error;
- (void)channel:(id)channel didReceiveServerMessage:(id)message;
- (void)channel:(id)channel didUpdateDeviceName:(id)name;
- (void)didSendMessageViaChannel:(id)channel;
- (void)didReceiveActionInGestureRecognizer:(id)recognizer;
- (void)debuggingInformationManager:(id)manager sendAnnotationResponse:(id)response;
@end

#endif /* WAGGestureClient_h */