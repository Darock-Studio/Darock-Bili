//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 417.0.4.0.0
//
#ifndef PRProximityEstimatorDelegate_Protocol_h
#define PRProximityEstimatorDelegate_Protocol_h
@import Foundation;

@protocol PRProximityEstimatorDelegate <NSObject>
/* instance methods */
- (void)estimator:(id)estimator didEstimateProximity:(long long)proximity toPeer:(id)peer;
@end

#endif /* PRProximityEstimatorDelegate_Protocol_h */