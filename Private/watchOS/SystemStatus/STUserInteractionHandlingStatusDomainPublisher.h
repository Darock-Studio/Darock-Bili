//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 165.19.0.0.0
//
#ifndef STUserInteractionHandlingStatusDomainPublisher_h
#define STUserInteractionHandlingStatusDomainPublisher_h
@import Foundation;

#include "STStatusDomainPublisher.h"

@interface STUserInteractionHandlingStatusDomainPublisher : STStatusDomainPublisher {
  /* instance variables */
  id /* block */ _userInteractionHandlerBlock;
}

/* instance methods */
- (void)handleUserInteractionsWithBlock:(id /* block */)block;
- (void)handleUserInteraction:(id)interaction forDomain:(unsigned long long)domain;
@end

#endif /* STUserInteractionHandlingStatusDomainPublisher_h */