//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 624.0.100.0.0
//
#ifndef ISTransitionApplier_h
#define ISTransitionApplier_h
@import Foundation;

#include "CAAnimationDelegate-Protocol.h"

@class NSString;

@interface ISTransitionApplier : NSObject<CAAnimationDelegate>

@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)defaultApplier;

/* instance methods */
- (void)applyOutputInfo:(id)info withTransitionOptions:(id)options toPhotoLayer:(id)layer videoLayer:(id)layer completion:(id /* block */)completion;
- (void)applyScale:(double)scale withTransitionOptions:(id)options toPhotoLayer:(id)layer videoLayer:(id)layer completion:(id /* block */)completion;
- (void)_applyAlpha:(double)alpha blurRadius:(double)radius toLayer:(id)layer withTransitionOptions:(id)options completion:(id /* block */)completion;
- (void)_applyScale:(double)scale toLayer:(id)layer withTransitionOptions:(id)options completion:(id /* block */)completion;
- (void)setValue:(id)value forKeyPath:(id)path ofLayer:(id)layer withTransitionOptions:(id)options completion:(id /* block */)completion;
- (void)animationDidStop:(id)stop finished:(BOOL)finished;
@end

#endif /* ISTransitionApplier_h */