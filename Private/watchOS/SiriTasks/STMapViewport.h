//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3302.23.5.2.1
//
#ifndef STMapViewport_h
#define STMapViewport_h
@import Foundation;

#include "STSiriModelObject.h"

@class NSArray;

@interface STMapViewport : STSiriModelObject

@property (nonatomic) double northLatitude;
@property (nonatomic) double southLatitude;
@property (nonatomic) double eastLongitude;
@property (nonatomic) double westLongitude;
@property (nonatomic) double timeSinceViewportChanged;
@property (nonatomic) double timeSinceViewportEnteredForeground;
@property (copy, nonatomic) NSArray *viewportVertices;

/* class methods */
+ (BOOL)supportsSecureCoding;

/* instance methods */
- (id)_aceContextObjectValue;
- (void)encodeWithCoder:(id)coder;
- (id)initWithCoder:(id)coder;
@end

#endif /* STMapViewport_h */