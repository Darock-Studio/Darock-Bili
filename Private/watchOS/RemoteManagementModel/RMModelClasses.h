//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 500.25.3.7.0
//
#ifndef RMModelClasses_h
#define RMModelClasses_h
@import Foundation;

@interface RMModelClasses : NSObject
/* class methods */
+ (Class)classForCommandType:(id)type;
+ (Class)classForDeclarationType:(id)type;
+ (void)hideDeclarationsWithTypes:(id)types;
+ (Class)classForStatusItemType:(id)type;
+ (id)allActivationClasses;
+ (id)allConfigurationClasses;
+ (id)allAssetClasses;
+ (id)allManagementClasses;
+ (id)allStatusItemClasses;
@end

#endif /* RMModelClasses_h */