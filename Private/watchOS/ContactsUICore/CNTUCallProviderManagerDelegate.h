//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3505.0.0.0.0
//
#ifndef CNTUCallProviderManagerDelegate_h
#define CNTUCallProviderManagerDelegate_h
@import Foundation;

#include "TUCallProviderManagerDelegate-Protocol.h"

@class NSString;

@interface CNTUCallProviderManagerDelegate : NSObject<TUCallProviderManagerDelegate>

@property (readonly, copy, nonatomic) id /* block */ block;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (id)initWithBlock:(id /* block */)block;
- (void)providersChangedForProviderManager:(id)manager;
@end

#endif /* CNTUCallProviderManagerDelegate_h */