//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3.2.4.0.0
//
#ifndef FBSSceneSettings_BacklightServices_h
#define FBSSceneSettings_BacklightServices_h
@import Foundation;

@interface FBSSceneSettings (BacklightServices) <BLSBacklightSceneSettings>
/* instance methods */
- (BOOL)bls_isDelegateActive;
- (BOOL)bls_isBlanked;
- (id)bls_visualState;
- (id)bls_presentationDate;
- (BOOL)bls_isAlwaysOnEnabledForEnvironment;
- (unsigned long long)bls_renderSeed;
- (BOOL)bls_isLiveUpdating;
- (BOOL)bls_hasUnrestrictedFramerateUpdates;
@end

#endif /* FBSSceneSettings_BacklightServices_h */