//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 651.5.0.0.0
//
#ifndef BSCopyingCacheSet_h
#define BSCopyingCacheSet_h
@import Foundation;

@class NSMutableSet, NSSet;

@interface BSCopyingCacheSet : NSObject {
  /* instance variables */
  NSMutableSet *_mutable;
  NSSet *_immutable;
}

@property (readonly) unsigned long long count;

/* instance methods */
- (void)addObject:(id)object;
- (void)removeObject:(id)object;
- (BOOL)containsObject:(id)object;
- (id)immutableSet;
- (id)description;
@end

#endif /* BSCopyingCacheSet_h */