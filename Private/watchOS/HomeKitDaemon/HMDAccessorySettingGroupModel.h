//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1092.3.10.0.0
//
#ifndef HMDAccessorySettingGroupModel_h
#define HMDAccessorySettingGroupModel_h
@import Foundation;

#include "HMDBackingStoreModelObject.h"

@class NSString;

@interface HMDAccessorySettingGroupModel : HMDBackingStoreModelObject

@property (copy, @dynamic, nonatomic) NSString *name;

/* class methods */
+ (id)schemaHashRoot;
+ (id)properties;
@end

#endif /* HMDAccessorySettingGroupModel_h */