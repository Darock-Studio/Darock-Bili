//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1431.300.81.0.0
//
#ifndef TUMetadataCache_h
#define TUMetadataCache_h
@import Foundation;

#include "TUMetadataCacheDataProviderDelegate-Protocol.h"

@class NSArray, NSString;
@protocol OS_dispatch_queue;

@interface TUMetadataCache : NSObject<TUMetadataCacheDataProviderDelegate>

@property (readonly, nonatomic) NSObject<OS_dispatch_queue> *queue;
@property (readonly, copy, nonatomic) NSArray *providers;
@property (readonly, nonatomic) BOOL empty;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)classIdentifier;

/* instance methods */
- (id)init;
- (id)initWithDataProviders:(id)providers;
- (id)initWithQueue:(id)queue dataProviders:(id)providers;
- (id)metadataForDestinationID:(id)id;
- (void)updateCacheWithDestinationIDs:(id)ids;
- (void)updateCacheForEmptyDataProvidersWithDestinationIDs:(id)ids;
- (void)_updateCacheWithDestinationIDs:(id)ids onlyEmptyProviders:(BOOL)providers;
- (BOOL)isEmpty;
- (void)dataProvider:(id)provider requestedRefreshWithDestinationIDs:(id)ids;
@end

#endif /* TUMetadataCache_h */