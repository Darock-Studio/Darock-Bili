//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 598.10.0.0.0
//
#ifndef BKSRestartAction_h
#define BKSRestartAction_h
@import Foundation;

#include "BSAction.h"

@interface BKSRestartAction : BSAction

@property (readonly, nonatomic) unsigned long long options;

/* class methods */
+ (id)actionWithOptions:(unsigned long long)options;
@end

#endif /* BKSRestartAction_h */