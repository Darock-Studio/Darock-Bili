//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 205.6.1.0.0
//
#ifndef VCPPersonObservation_h
#define VCPPersonObservation_h
@import Foundation;

@class NSArray;

@interface VCPPersonObservation : NSObject

@property (retain, nonatomic) NSArray *keypoints;
@property (nonatomic) float relativeActionScore;
@property (nonatomic) float absoluteActionScore;
@property (nonatomic) int personID;
@property (nonatomic) int revision;

/* instance methods */
@end

#endif /* VCPPersonObservation_h */