//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 396.4.0.0.0
//
#ifndef TRIFactorLevel_h
#define TRIFactorLevel_h
@import Foundation;

#include "TRIPBMessage.h"
#include "TRIFactor.h"
#include "TRILevel.h"

@interface TRIFactorLevel : TRIPBMessage

@property (retain, @dynamic, nonatomic) TRIFactor *factor;
@property (@dynamic, nonatomic) BOOL hasFactor;
@property (retain, @dynamic, nonatomic) TRILevel *level;
@property (@dynamic, nonatomic) BOOL hasLevel;

/* class methods */
+ (id)hashForFactorLevels:(id)levels;
+ (id)descriptor;

/* instance methods */
- (id)uniqueDataRepresentation;
@end

#endif /* TRIFactorLevel_h */