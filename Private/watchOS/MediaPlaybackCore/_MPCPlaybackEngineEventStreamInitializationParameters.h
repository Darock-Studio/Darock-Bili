//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 4023.330.3.0.0
//
#ifndef _MPCPlaybackEngineEventStreamInitializationParameters_h
#define _MPCPlaybackEngineEventStreamInitializationParameters_h
@import Foundation;

#include "MPCPlaybackEngineEventStreamInitializationParameters-Protocol.h"

@class NSString;

@interface _MPCPlaybackEngineEventStreamInitializationParameters : NSObject<MPCPlaybackEngineEventStreamInitializationParameters>

@property (readonly, copy, nonatomic) NSString *originID;
@property (readonly, copy, nonatomic) NSString *playerID;
@property (readonly, copy, nonatomic) NSString *engineID;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (id)initWithPlaybackEngineParameters:(id)parameters engineID:(id)id;
@end

#endif /* _MPCPlaybackEngineEventStreamInitializationParameters_h */