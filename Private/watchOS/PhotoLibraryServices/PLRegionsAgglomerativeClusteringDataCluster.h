//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 624.0.100.0.0
//
#ifndef PLRegionsAgglomerativeClusteringDataCluster_h
#define PLRegionsAgglomerativeClusteringDataCluster_h
@import Foundation;

@class NSArray;

@interface PLRegionsAgglomerativeClusteringDataCluster : NSObject

@property (readonly) NSArray *vectors;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic) double radius;
@property (nonatomic) double score;

/* class methods */
+ (id)dataClusterWithDataVector:(id)vector;
+ (id)mergedClusterFrom:(id)from;

/* instance methods */
- (id)initWithDataVector:(id)vector;
- (id)description;
@end

#endif /* PLRegionsAgglomerativeClusteringDataCluster_h */