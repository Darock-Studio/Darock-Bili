//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 140.0.0.0.0
//
#ifndef MOApplicationSettingsGroup_h
#define MOApplicationSettingsGroup_h
@import Foundation;

#include "MOSettingsGroup.h"

@class NSNumber, NSSet;

@interface MOApplicationSettingsGroup : MOSettingsGroup

@property (retain, nonatomic) NSSet *blockedApplications;
@property (retain, nonatomic) NSNumber *denyAppInstallation;
@property (retain, nonatomic) NSNumber *denyAppRemoval;
@property (retain, nonatomic) NSSet *unremovableApplications;

/* class methods */
+ (id)groupName;
+ (id)blockedApplicationsMetadata;
+ (id)denyAppInstallationMetadata;
+ (id)denyAppRemovalMetadata;
+ (id)unremovableApplicationsMetadata;
@end

#endif /* MOApplicationSettingsGroup_h */