//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 402.23.0.0.0
//
#ifndef CHSIconResolver_h
#define CHSIconResolver_h
@import Foundation;

#include "CHSIconResolving-Protocol.h"

@interface CHSIconResolver : NSObject<CHSIconResolving> {
  /* instance variables */
   iconStore;
}

/* instance methods */
- (id)init;
- (void)resolveIconForContainerIdentity:(id)identity completion:(id /* block */)completion;
- (id)resolveIconVersionForExtensionIdentity:(id)identity;
@end

#endif /* CHSIconResolver_h */