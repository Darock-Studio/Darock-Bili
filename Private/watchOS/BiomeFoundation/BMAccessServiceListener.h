//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 123.2.7.0.1
//
#ifndef BMAccessServiceListener_h
#define BMAccessServiceListener_h
@import Foundation;

#include "BMAccessServer.h"
#include "BMAccessServiceBase-Protocol.h"
#include "BMFileServer-Protocol.h"
#include "NSXPCConnectionDelegate-Protocol.h"
#include "NSXPCListenerDelegate-Protocol.h"

@class NSMapTable, NSString, NSXPCListener, NSXPCListenerEndpoint;
@protocol OS_dispatch_queue;

@interface BMAccessServiceListener : NSObject<NSXPCConnectionDelegate, BMAccessServiceBase, NSXPCListenerDelegate> {
  /* instance variables */
  NSObject<OS_dispatch_queue> *_queue;
  NSXPCListener *_listener;
  BMAccessServer *_accessServer;
  NSObject<BMFileServer> *_fileServer;
  NSMapTable *_clientSpecificListeners;
}

@property (readonly, nonatomic) unsigned long long domain;
@property (readonly, nonatomic) NSXPCListenerEndpoint *endpoint;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (id)initLegacyWithQueue:(id)queue;
- (id)initWithMachServiceName:(id)name domain:(unsigned long long)domain queue:(id)queue accessServer:(id)server fileServer:(id)server;
- (id)initWithDomain:(unsigned long long)domain queue:(id)queue delegate:(id)delegate;
- (id)initWithMachServiceName:(id)name domain:(unsigned long long)domain queue:(id)queue accessServer:(id)server fileServer:(id)server delegate:(id)delegate;
- (void)activate;
- (void)dealloc;
- (BOOL)listener:(id)listener shouldAcceptNewConnection:(id)connection;
- (BOOL)_acceptConnection:(id)connection;
- (void)replyToInvocation:(id)invocation withError:(id)error;
- (void)connection:(id)connection handleInvocation:(id)invocation isReply:(BOOL)reply;
- (void)configureConnectionForUseCase:(id)case reply:(id /* block */)reply;
- (id)uniqueEndpointForAppScopedServicesActingOnBehalfOfClientWithAccessControlPolicy:(id)policy;
@end

#endif /* BMAccessServiceListener_h */