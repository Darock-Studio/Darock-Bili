//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 64562.3.1.1.0
//
#ifndef DTCompanionControlServiceV2_h
#define DTCompanionControlServiceV2_h
@import Foundation;

#include "DTXService.h"
#include "DTCompanionControlServiceV2API-Protocol.h"

@class NSString;

@interface DTCompanionControlServiceV2 : DTXService<DTCompanionControlServiceV2API>

@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (void)instantiateServiceWithChannel:(id)channel;
+ (void)setSockPuppetSymbols:(struct { id * x0; id * x1; id * x2; id * x3; id * x4; id * x5; id * x6; undefined * x7; undefined * x8; undefined * x9; undefined * x10; undefined * x11; })symbols;
+ (struct { id * x0; id * x1; id * x2; id * x3; id * x4; id * x5; id * x6; undefined * x7; undefined * x8; undefined * x9; undefined * x10; undefined * x11; })sockPuppetSymbols;
+ (void)registerCapabilities:(id)capabilities;

/* instance methods */
- (id)_launchModeTranslationsMap;
- (id)willInstallWatchAppForCompanionIdentifier:(id)identifier;
- (id)launchWatchAppForCompanionIdentifier:(id)identifier options:(id)options;
- (id)terminateWatchAppForCompanionIdentifier:(id)identifier options:(id)options;
@end

#endif /* DTCompanionControlServiceV2_h */