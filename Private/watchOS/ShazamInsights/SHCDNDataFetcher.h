//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 236.12.0.0.0
//
#ifndef SHCDNDataFetcher_h
#define SHCDNDataFetcher_h
@import Foundation;

#include "SHDataFetcher-Protocol.h"
#include "SHNetworkRequester-Protocol.h"

@class NSString;

@interface SHCDNDataFetcher : NSObject<SHDataFetcher>

@property (readonly, nonatomic) NSObject<SHNetworkRequester> *networkRequester;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (id)init;
- (id)initWithNetworkRequester:(id)requester;
- (void)fetchClusterURL:(id)url forCurrentStorefront:(id)storefront cachedUniqueHash:(id)hash completionHandler:(id /* block */)handler;
- (BOOL)doesRequestEtag:(id)etag matchInResponse:(id)response;
- (void)clusterDataAtURL:(id)url forLocation:(id)location date:(id)date completionHandler:(id /* block */)handler;
- (id)endpointFromDate:(id)date insights:(id)insights location:(id)location;
@end

#endif /* SHCDNDataFetcher_h */