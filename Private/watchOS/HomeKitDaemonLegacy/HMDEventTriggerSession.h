//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1092.3.10.0.0
//
#ifndef HMDEventTriggerSession_h
#define HMDEventTriggerSession_h
@import Foundation;

#include "HMFObject.h"
#include "HMDDevice.h"
#include "HMDEventTrigger.h"
#include "HMDHomeMessageReceiver-Protocol.h"
#include "HMFDumpState-Protocol.h"
#include "HMFLogging-Protocol.h"

@class HMFMessageDispatcher, NSSet, NSString, NSUUID;
@protocol OS_dispatch_queue;

@interface HMDEventTriggerSession : HMFObject<HMFDumpState, HMFLogging, HMDHomeMessageReceiver>

@property (readonly, nonatomic) NSUUID *sessionID;
@property (readonly, nonatomic) NSString *logString;
@property (readonly, nonatomic) HMFMessageDispatcher *msgDispatcher;
@property (readonly, nonatomic) NSObject<OS_dispatch_queue> *workQueue;
@property (weak, nonatomic) HMDEventTrigger *eventTrigger;
@property (readonly, nonatomic) NSUUID *eventTriggerUUID;
@property (readonly, nonatomic) HMDDevice *currentDevice;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;
@property (readonly, copy) NSSet *messageReceiverChildren;
@property (readonly, nonatomic) NSUUID *messageTargetUUID;
@property (readonly, nonatomic) NSObject<OS_dispatch_queue> *messageReceiveQueue;

/* class methods */
+ (id)logCategory;
+ (BOOL)hasMessageReceiverChildren;

/* instance methods */
- (id)initWithSessionID:(id)id eventTrigger:(id)trigger workQueue:(id)queue msgDispatcher:(id)dispatcher;
- (void)dealloc;
- (void)_registerForMessages;
- (id)dumpState;
- (id)logIdentifier;
- (BOOL)sendResidentMessage:(id)message payload:(id)payload responseHandler:(id /* block */)handler;
- (BOOL)sendMessage:(id)message payload:(id)payload device:(id)device responseHandler:(id /* block */)handler;
- (BOOL)sendMessage:(id)message payload:(id)payload device:(id)device target:(id)target responseHandler:(id /* block */)handler;
@end

#endif /* HMDEventTriggerSession_h */