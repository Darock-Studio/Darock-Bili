//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 4023.330.3.0.0
//
#ifndef MPCSharedListeningQueueEventContentAdded_h
#define MPCSharedListeningQueueEventContentAdded_h
@import Foundation;

@class MPModelGenericObject, NSArray;

@interface MPCSharedListeningQueueEventContentAdded : NSObject

@property (readonly, nonatomic) MPModelGenericObject *container;
@property (readonly, copy, nonatomic) NSArray *items;

/* instance methods */
- (id)initWithItems:(id)items container:(id)container;
- (id)description;
@end

#endif /* MPCSharedListeningQueueEventContentAdded_h */