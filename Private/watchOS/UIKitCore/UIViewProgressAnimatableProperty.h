//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 7209.1.301.0.0
//
#ifndef UIViewProgressAnimatableProperty_h
#define UIViewProgressAnimatableProperty_h
@import Foundation;

#include "UIViewFloatAnimatableProperty.h"

@interface UIViewProgressAnimatableProperty : UIViewFloatAnimatableProperty
/* class methods */
+ (id)progressAnimatablePropertyByPerforming:(id /* block */)performing;
+ (id)propertyAnimatorByPerforming:(id /* block */)performing;
@end

#endif /* UIViewProgressAnimatableProperty_h */