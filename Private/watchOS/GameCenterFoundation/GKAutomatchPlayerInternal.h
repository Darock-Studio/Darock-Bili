//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 818.2.23.4.1
//
#ifndef GKAutomatchPlayerInternal_h
#define GKAutomatchPlayerInternal_h
@import Foundation;

#include "GKSpecialPlayerInternal.h"

@class NSString;

@interface GKAutomatchPlayerInternal : GKSpecialPlayerInternal

@property (nonatomic) long long automatchPosition;
@property (readonly, nonatomic) NSString *automatchPositionDisplayString;

/* class methods */
+ (BOOL)supportsSecureCoding;

/* instance methods */
- (id)playerID;
- (id)alias;
- (BOOL)isAutomatchPlayer;
@end

#endif /* GKAutomatchPlayerInternal_h */