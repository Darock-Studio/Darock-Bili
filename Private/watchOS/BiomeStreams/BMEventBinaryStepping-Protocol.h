//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 123.2.7.0.1
//
#ifndef BMEventBinaryStepping_Protocol_h
#define BMEventBinaryStepping_Protocol_h
@import Foundation;

@protocol BMEventBinaryStepping <BMStreamValidating>

@property (nonatomic) BOOL starting;

/* instance methods */
- (BOOL)isStarting;
@end

#endif /* BMEventBinaryStepping_Protocol_h */