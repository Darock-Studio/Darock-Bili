//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 252.9.0.0.0
//
#ifndef FTMutableTextToSpeechRequestDevConfig_h
#define FTMutableTextToSpeechRequestDevConfig_h
@import Foundation;

#include "FTTextToSpeechRequestDevConfig.h"

@class NSString;

@interface FTMutableTextToSpeechRequestDevConfig : FTTextToSpeechRequestDevConfig

@property (nonatomic) BOOL return_log;
@property (copy, nonatomic) NSString *voice_asset_path;
@property (copy, nonatomic) NSString *resource_asset_path;
@property (nonatomic) BOOL return_server_info;

/* instance methods */
- (id)init;
- (id)copyWithZone:(struct _NSZone *)zone;
@end

#endif /* FTMutableTextToSpeechRequestDevConfig_h */