//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 165.19.0.0.0
//
#ifndef STMutableBackgroundActivitiesStatusDomainDataChangeContext_h
#define STMutableBackgroundActivitiesStatusDomainDataChangeContext_h
@import Foundation;

#include "STBackgroundActivitiesStatusDomainDataChangeContext.h"
#include "STMutableStatusDomainDataChangeContext-Protocol.h"

@class NSString;

@interface STMutableBackgroundActivitiesStatusDomainDataChangeContext : STBackgroundActivitiesStatusDomainDataChangeContext<STMutableStatusDomainDataChangeContext>

@property (@dynamic, nonatomic) BOOL userInitiated;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (id)copyWithZone:(struct _NSZone *)zone;
@end

#endif /* STMutableBackgroundActivitiesStatusDomainDataChangeContext_h */