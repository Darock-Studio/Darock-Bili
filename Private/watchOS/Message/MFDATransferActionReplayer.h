//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3774.300.42.0.0
//
#ifndef MFDATransferActionReplayer_h
#define MFDATransferActionReplayer_h
@import Foundation;

#include "ECTransferActionReplayer.h"
#include "ECTransferActionReplayerSubclassMethods-Protocol.h"
#include "MFDAMessageStore.h"

@class NSString;

@interface MFDATransferActionReplayer : ECTransferActionReplayer<ECTransferActionReplayerSubclassMethods>

@property (retain, nonatomic) MFDAMessageStore *store;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (id)replayActionUsingStore:(id)store;
- (id)appendItem:(id)item mailboxURL:(id)url;
- (BOOL)deleteSourceMessagesFromTransferItems:(id)items;
- (id)copyItems:(id)items destinationMailboxURL:(id)url;
- (id)moveItems:(id)items destinationMailboxURL:(id)url;
- (id)fetchBodyDataForRemoteID:(id)id mailboxURL:(id)url;
- (BOOL)downloadFailed;
- (BOOL)isRecoverableError:(id)error;
@end

#endif /* MFDATransferActionReplayer_h */