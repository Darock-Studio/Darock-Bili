//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1852.4.7.0.3
//
#ifndef _DKObjectFromMOCache_h
#define _DKObjectFromMOCache_h
@import Foundation;

@class NSMutableDictionary;

@interface _DKObjectFromMOCache : NSObject {
  /* instance variables */
  NSMutableDictionary *_cache;
  NSMutableDictionary *_cacheEntries;
  NSMutableDictionary *_cacheHits;
  NSMutableDictionary *_cacheMisses;
}

/* instance methods */
- (id)init;
@end

#endif /* _DKObjectFromMOCache_h */