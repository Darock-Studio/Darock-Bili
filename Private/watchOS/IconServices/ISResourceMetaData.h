//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 597.5.2.1.0
//
#ifndef ISResourceMetaData_h
#define ISResourceMetaData_h
@import Foundation;

#include "ISResourceMetadata-Protocol.h"

@class NSNumber, NSString;

@interface ISResourceMetaData : NSObject<ISResourceMetadata>

@property (retain) NSString *name;
@property (retain) NSNumber *dimension;
@property (retain) NSNumber *scale;
@property BOOL selectedVariant;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
@end

#endif /* ISResourceMetaData_h */