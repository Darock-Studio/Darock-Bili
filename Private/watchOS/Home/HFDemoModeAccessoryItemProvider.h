//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 841.3.9.0.0
//
#ifndef HFDemoModeAccessoryItemProvider_h
#define HFDemoModeAccessoryItemProvider_h
@import Foundation;

#include "HFItemProvider.h"

@class HMHome, NSSet;

@interface HFDemoModeAccessoryItemProvider : HFItemProvider

@property (retain, nonatomic) HMHome *home;
@property (retain, nonatomic) NSSet *demoItems;
@property (copy, nonatomic) id /* block */ filter;

/* instance methods */
- (id)initWithHome:(id)home;
- (id)init;
- (id)copyWithZone:(struct _NSZone *)zone;
- (id)reloadItems;
- (id)items;
- (id)invalidationReasons;
@end

#endif /* HFDemoModeAccessoryItemProvider_h */