//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 617.0.0.0.0
//
#ifndef FCUserVectorManager_h
#define FCUserVectorManager_h
@import Foundation;

#include "FCAppActivityObserving-Protocol.h"
#include "FCAsyncSerialQueue.h"
#include "FCCloudContext.h"
#include "FCReadonlyAggregateStoreProviderType-Protocol.h"
#include "FCUserVector.h"

@class NSDate, NSString;

@interface FCUserVectorManager : NSObject<FCAppActivityObserving>

@property (retain, nonatomic) FCAsyncSerialQueue *queue;
@property (retain, nonatomic) FCUserVector *userVector;
@property (retain, nonatomic) FCCloudContext *context;
@property (retain, nonatomic) NSDate *lastUpdated;
@property (retain, nonatomic) NSObject<FCReadonlyAggregateStoreProviderType> *aggregateStoreProvider;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (id)initWithContext:(id)context;
- (void)activityObservingApplicationWindowDidBecomeForeground;
- (void)activityObservingApplicationWindowDidBecomeBackground;
- (void)activityObservingApplicationWillTerminate;
- (void)_applicationDidEnterForeground;
- (void)_applicationDidEnterBackground;
- (void)_submitPersonalizationVector;
- (void)_cacheGSToken;
- (void)_fetchUserVector:(id /* block */)vector;
@end

#endif /* FCUserVectorManager_h */