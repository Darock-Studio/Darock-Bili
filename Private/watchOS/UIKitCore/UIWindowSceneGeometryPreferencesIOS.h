//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 7209.1.301.0.0
//
#ifndef UIWindowSceneGeometryPreferencesIOS_h
#define UIWindowSceneGeometryPreferencesIOS_h
@import Foundation;

#include "UIWindowSceneGeometryPreferences.h"

@interface UIWindowSceneGeometryPreferencesIOS : UIWindowSceneGeometryPreferences

@property (nonatomic) unsigned long long interfaceOrientations;

/* instance methods */
- (id)init;
- (id)initWithInterfaceOrientations:(unsigned long long)orientations;
- (long long)_type;
- (unsigned long long)hash;
- (BOOL)isEqual:(id)equal;
@end

#endif /* UIWindowSceneGeometryPreferencesIOS_h */