//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 114.2.2.0.0
//
#ifndef WAGGestureServerXPCConnection_h
#define WAGGestureServerXPCConnection_h
@import Foundation;

#include "WAGGestureServerConnectionProtocol-Protocol.h"
#include "WAGGestureServerXPCConnectionDelegate-Protocol.h"
#include "WAGPClientMetadata.h"

@class NSString, NSXPCConnection;

@interface WAGGestureServerXPCConnection : NSObject<WAGGestureServerConnectionProtocol>

@property (readonly, nonatomic) NSXPCConnection *connection;
@property (weak, nonatomic) NSObject<WAGGestureServerXPCConnectionDelegate> *delegate;
@property (retain, nonatomic) WAGPClientMetadata *metadata;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (id)initWithConnection:(id)connection;
- (void)start;
- (void)sendServerMessageWithData:(id)data completionBlock:(id /* block */)block;
- (void)sendMessage:(id)message completionHandler:(id /* block */)handler;
- (void)disconnect;
@end

#endif /* WAGGestureServerXPCConnection_h */