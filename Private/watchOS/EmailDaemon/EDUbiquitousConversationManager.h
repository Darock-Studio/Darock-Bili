//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3774.300.42.0.0
//
#ifndef EDUbiquitousConversationManager_h
#define EDUbiquitousConversationManager_h
@import Foundation;

#include "EDConversationRemoteStorage-Protocol.h"
#include "EDConversationRemoteStorageDelegate-Protocol.h"
#include "EDUbiquitousConversationManagerDelegate-Protocol.h"
#include "EFLoggable-Protocol.h"

@class NSMutableDictionary, NSMutableSet, NSString;
@protocol OS_dispatch_queue;

@interface EDUbiquitousConversationManager : NSObject<EDConversationRemoteStorageDelegate, EFLoggable>

@property (weak, nonatomic) NSObject<EDUbiquitousConversationManagerDelegate> *delegate;
@property (retain, nonatomic) NSObject<EDConversationRemoteStorage> *cloudStorage;
@property (retain, nonatomic) NSObject<OS_dispatch_queue> *queue;
@property (retain, nonatomic) NSMutableDictionary *conversationIDsBySyncKey;
@property (retain, nonatomic) NSMutableSet *unmatchedKeys;
@property (nonatomic) BOOL initialized;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)log;

/* instance methods */
- (id)initWithDelegate:(id)delegate;
- (void)performInitialSync;
- (BOOL)hasSubscribedConversations;
- (id)syncKeyForUpdatedConversation:(long long)conversation flags:(unsigned long long)flags;
- (void)setFlags:(unsigned long long)flags forConversations:(id)conversations;
- (void)_setCloudStorageValue:(id)value forKey:(id)key;
- (id)_syncKeyForConversationID:(long long)id;
- (BOOL)_synchronize;
- (void)_mergeServerChanges:(id)changes;
- (void)pruneDatabasePurgingOldestEntries:(BOOL)entries;
- (void)conversationRemoteStorage:(id)storage didChangeEntries:(id)entries reason:(long long)reason;
- (void)performDailyExportForChangedConversations:(id)conversations;
@end

#endif /* EDUbiquitousConversationManager_h */