//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1092.3.10.0.0
//
#ifndef HMMCounterDatePartitionProvider_Protocol_h
#define HMMCounterDatePartitionProvider_Protocol_h
@import Foundation;

@protocol HMMCounterDatePartitionProvider <NSObject>

@property (readonly, copy, nonatomic) NSDate *currentDatePartition;

/* instance methods */
- (id)datePartitionWithOffsetFromNow:(long long)now;
@end

#endif /* HMMCounterDatePartitionProvider_Protocol_h */