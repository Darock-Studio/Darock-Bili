//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 396.4.0.0.0
//
#ifndef TRIPBStruct_h
#define TRIPBStruct_h
@import Foundation;

#include "TRIPBMessage.h"

@class NSMutableDictionary;

@interface TRIPBStruct : TRIPBMessage

@property (retain, @dynamic, nonatomic) NSMutableDictionary *fields;
@property (readonly, @dynamic, nonatomic) unsigned long long fields_Count;

/* class methods */
+ (id)descriptor;
@end

#endif /* TRIPBStruct_h */