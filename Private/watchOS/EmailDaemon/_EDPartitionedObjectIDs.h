//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3774.300.42.0.0
//
#ifndef _EDPartitionedObjectIDs_h
#define _EDPartitionedObjectIDs_h
@import Foundation;

@class NSArray, NSDictionary;

@interface _EDPartitionedObjectIDs : NSObject

@property (readonly, copy, nonatomic) NSArray *messageObjectIDs;
@property (readonly, copy, nonatomic) NSDictionary *threadObjectIDsByScope;

/* instance methods */
- (id)initWithMessageObjectIDs:(id)ids threadObjectIDsByScope:(id)scope;
@end

#endif /* _EDPartitionedObjectIDs_h */