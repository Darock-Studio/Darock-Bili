//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 4146.2.12.2.2
//
#ifndef HDIDSDestination_h
#define HDIDSDestination_h
@import Foundation;

#include "NSCopying-Protocol.h"

@interface HDIDSDestination : NSObject<NSCopying>

@property (readonly, copy, nonatomic) id /* block */ deviceFilterBlock;

/* class methods */
+ (id)initWithAllowedDeviceTypes:(id)types;
+ (id)validHealthSoftwareDeviceTypes;

/* instance methods */
- (id)initWithDeviceFilterBlock:(id /* block */)block;
- (id)copyWithZone:(struct _NSZone *)zone;
@end

#endif /* HDIDSDestination_h */