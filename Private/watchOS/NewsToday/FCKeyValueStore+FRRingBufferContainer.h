//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 617.0.0.0.0
//
#ifndef FCKeyValueStore_FRRingBufferContainer_h
#define FCKeyValueStore_FRRingBufferContainer_h
@import Foundation;

@interface FCKeyValueStore (FRRingBufferContainer) <FRRingBufferContainer>
/* instance methods */
- (id)ringBufferForKey:(id)key capacity:(unsigned long long)capacity;
- (id)ringBufferForKey:(id)key;
- (void)setRingBuffers:(id)buffers;
- (BOOL)hasMinForKey:(id)key;
- (BOOL)hasMaxForKey:(id)key;
- (double)minForKey:(id)key;
- (double)maxForKey:(id)key;
@end

#endif /* FCKeyValueStore_FRRingBufferContainer_h */