//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1226.2.2.1.0
//
#ifndef PPFeatureRedactor_h
#define PPFeatureRedactor_h
@import Foundation;

#include "PPTrialWrapper.h"

@class _PASLock;

@interface PPFeatureRedactor : NSObject {
  /* instance variables */
  _PASLock *_lock;
  PPTrialWrapper *_trialWrapper;
}

/* instance methods */
- (id)initWithTrialWrapper:(id)wrapper namespaceName:(id)name;
- (void)transformFeaturesInPlace:(id)place;
@end

#endif /* PPFeatureRedactor_h */