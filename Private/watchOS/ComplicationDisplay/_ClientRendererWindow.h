//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 2398.45.8.0.0
//
#ifndef _ClientRendererWindow_h
#define _ClientRendererWindow_h
@import Foundation;

#include "UIWindow.h"

@interface _ClientRendererWindow : UIWindow
/* class methods */
+ (BOOL)_isSecure;

/* instance methods */
- (id)init;
- (BOOL)_shouldUseRemoteContext;
- (BOOL)_wantsSceneAssociation;
- (BOOL)_isWindowServerHostingManaged;
- (BOOL)_alwaysGetsContexts;
- (long long)_orientationForViewTransform;
- (long long)_orientationForRootTransform;
@end

#endif /* _ClientRendererWindow_h */