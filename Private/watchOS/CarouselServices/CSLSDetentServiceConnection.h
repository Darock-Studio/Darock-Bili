//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1112.2.15.0.0
//
#ifndef CSLSDetentServiceConnection_h
#define CSLSDetentServiceConnection_h
@import Foundation;

#include "CSLSDetentClient-Protocol.h"
#include "CSLSDetentService-Protocol.h"

@class NSString, NSXPCConnection;

@interface CSLSDetentServiceConnection : NSObject<CSLSDetentService, CSLSDetentClient> {
  /* instance variables */
  NSXPCConnection *_connection;
  struct os_unfair_recursive_lock_s { struct os_unfair_lock_s { unsigned int _os_unfair_lock_opaque; } ourl_lock; unsigned int ourl_count; } _lock;
}

@property (readonly, weak, nonatomic) NSObject<CSLSDetentClient> *delegate;
@property (nonatomic) BOOL assertionTaken;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)serviceName;
+ (id)CSLSDetentService;
+ (id)CSLSDetentClient;
+ (id)log;

/* instance methods */
- (id)initWithQueue:(id)queue delegate:(id)delegate;
- (id)init;
- (id)_remoteObjectProxy:(id /* block */)proxy;
- (void)_withLock:(id /* block */)lock;
- (void)_retakeAssertionIfNecessary;
- (void)takeDetentAssertion:(id /* block */)assertion;
- (void)releaseDetentAssertion:(id /* block */)assertion;
- (void)getPreferences:(id /* block */)preferences;
- (void)detentsDisabledChanged:(BOOL)changed;
- (void)detentsDebugChanged:(BOOL)changed;
- (void)flashDetentsChanged:(BOOL)changed;
- (void)detentsChanged:(id)changed;
- (void)recordMetrics:(id)metrics;
@end

#endif /* CSLSDetentServiceConnection_h */