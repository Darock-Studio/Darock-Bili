//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 2206.0.5.0.0
//
#ifndef WFUIPresenterXPCConnection_h
#define WFUIPresenterXPCConnection_h
@import Foundation;

#include "WFUIPresenterConnection-Protocol.h"
#include "WFUIPresenterHostInterface-Protocol.h"

@class NSString, NSXPCConnection;

@interface WFUIPresenterXPCConnection : NSObject<WFUIPresenterConnection>

@property (readonly, nonatomic) NSXPCConnection *connection;
@property (readonly, nonatomic) struct os_unfair_lock_s { unsigned int x0; } lock;
@property (nonatomic) BOOL connected;
@property (copy, nonatomic) id /* block */ errorHandler;
@property (nonatomic) NSObject<WFUIPresenterHostInterface> *host;
@property (readonly, nonatomic) BOOL isConnected;
@property (copy, nonatomic) id /* block */ interruptionHandler;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (id)initWithMachServiceName:(id)name;
- (id)initWithEndpoint:(id)endpoint;
- (id)initWithServiceName:(id)name;
- (id)initWithConnection:(id)connection;
- (void)resumeConnectionIfNecessary;
- (id)presenterWithErrorHandler:(id /* block */)handler;
- (id)synchronousPresenterWithErrorHandler:(id /* block */)handler;
@end

#endif /* WFUIPresenterXPCConnection_h */