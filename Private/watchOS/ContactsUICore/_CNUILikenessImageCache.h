//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3505.0.0.0.0
//
#ifndef _CNUILikenessImageCache_h
#define _CNUILikenessImageCache_h
@import Foundation;

@class CNCache, CNQueue, CNUnfairLock;
@protocol OS_dispatch_source;

@interface _CNUILikenessImageCache : NSObject

@property (retain, nonatomic) NSObject<OS_dispatch_source> *memoryMonitoringSource;
@property (retain, nonatomic) CNCache *cache;
@property (retain, nonatomic) CNQueue *evictionQueue;
@property (retain, nonatomic) CNUnfairLock *lock;

/* instance methods */
- (id)initWithCapacity:(unsigned long long)capacity hasContactStore:(BOOL)store;
- (void)emptyCache:(id)cache;
- (void)refreshCacheKey:(id)key;
- (void)invalidateCacheEntriesContainingIdentifiers:(id)identifiers;
@end

#endif /* _CNUILikenessImageCache_h */