//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 617.0.0.0.0
//
#ifndef FCUserEventHistoryStorage_h
#define FCUserEventHistoryStorage_h
@import Foundation;

#include "FCNewsAppConfigurationManager-Protocol.h"
#include "FCUserEventHistoryMetadata.h"
#include "FCUserEventHistoryStorageType-Protocol.h"

@class NFLazy, NSArray, NSDate, NSHashTable, NSString, NSURL;

@interface FCUserEventHistoryStorage : NSObject<FCUserEventHistoryStorageType>

@property (retain, nonatomic) NFLazy *lazyRootDirectory;
@property (readonly, nonatomic) NSHashTable *observers;
@property (retain, nonatomic) NSArray *prunedSessionIDs;
@property (nonatomic) unsigned long long prunedSessionSize;
@property (retain, nonatomic) FCUserEventHistoryMetadata *metadata;
@property (nonatomic) unsigned long long currentSize;
@property (retain, nonatomic) NSObject<FCNewsAppConfigurationManager> *configurationManager;
@property (readonly, nonatomic) NSArray *sessionIDs;
@property (readonly, nonatomic) NSArray *sessions;
@property (readonly, nonatomic) NSDate *earliestSessionDate;
@property (readonly, nonatomic) unsigned long long size;
@property (readonly, nonatomic) NSURL *baseDirectoryURL;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (id)initWithPrivateDataDirectory:(id)directory;
- (id)initWithPrivateDataDirectory:(id)directory configurationManager:(id)manager;
- (id)sizeString;
- (id)rootDirectory;
- (void)addObserver:(id)observer;
- (void)removeObserver:(id)observer;
- (id)pruneWithPolicies:(id)policies;
- (void)clearSessionsWithIDs:(id)ids;
- (void)writeJSON:(id /* block */)json;
- (void)storeSessionID:(id)id compressedSessionData:(id)data notify:(BOOL)notify;
- (void)storeSessionID:(id)id sessionData:(id)data;
- (void)clearAllSessions;
- (void)clearHistory;
- (void)setMetadataWithAggregateStoreGenerationTime:(long long)time aggregateTotalCount:(long long)count meanCountOfEvents:(double)events standardDeviationOfEvents:(double)events totalEventsCount:(long long)count headlineEventCount:(long long)count headlinesWithValidTitleEmbeddingsEventCount:(long long)count headlinesWithInvalidTitleEmbeddingsEventCount:(long long)count headlinesWithValidBodyEmbeddingsEventCount:(long long)count headlinesWithInvalidBodyEmbeddingsEventCount:(long long)count eventCounts:(id)counts aggregateStoreData:(id)data;
- (id)_filePathForSessionID:(id)id;
- (id)_deleteSessions:(id)sessions pruned:(BOOL)pruned;
- (void)_pruneSessions:(id)sessions;
- (void)_pruneToMaxSize:(long long)size;
- (void)_pruneToMaxSessionCount:(unsigned long long)count;
- (void)_pruneToMaxSessionAge:(unsigned long long)age;
@end

#endif /* FCUserEventHistoryStorage_h */