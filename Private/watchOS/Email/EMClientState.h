//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3774.300.42.0.0
//
#ifndef EMClientState_h
#define EMClientState_h
@import Foundation;

#include "EFLoggable-Protocol.h"
#include "EMRemoteConnection.h"

@class NSString;
@protocol EFObservable<EFObserver;

@interface EMClientState : NSObject<EFLoggable>

@property (retain) EMRemoteConnection *connection;
@property (nonatomic) BOOL isForeground;
@property (retain, nonatomic) EFObservable<EFObserver> *foregroundObservable;
@property (nonatomic) BOOL isRunningTests;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)log;
+ (id)remoteInterface;

/* instance methods */
- (id)initWithRemoteConnection:(id)connection;
- (void)setCurrentlyVisibleMailboxes:(id)mailboxes;
- (void)setCurrentlyVisibleMailboxObjectIDs:(id)ids;
- (id)daemonBoosterWithDescription:(id)description;
- (void)_handleApplicationWillEnterForeground;
- (void)_handleApplicationDidEnterBackground;
- (void)test_handleApplicationWillEnterForeground;
- (void)test_handleApplicationDidEnterBackground;
- (void)setStateForDemoMode:(id /* block */)mode;
- (void)exitDaemon;
- (void)_performAsyncUpdate:(id /* block */)update;
@end

#endif /* EMClientState_h */