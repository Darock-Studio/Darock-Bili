//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 470.14.3.0.0
//
#ifndef CMIResourceMetalTextureDescriptor_h
#define CMIResourceMetalTextureDescriptor_h
@import Foundation;

#include "MTLCommandBuffer-Protocol.h"

@class NSDictionary;

@interface CMIResourceMetalTextureDescriptor : NSObject

@property (retain, nonatomic) NSDictionary *metadata;
@property (nonatomic) struct { long long x0; int x1; unsigned int x2; long long x3; } presentationTimeStamp;
@property (nonatomic) unsigned int matchingPixelBufferFormat;
@property (retain, nonatomic) NSDictionary *attachments;
@property (retain, nonatomic) NSObject<MTLCommandBuffer> *commandBuffer;

/* instance methods */
- (id)init;
@end

#endif /* CMIResourceMetalTextureDescriptor_h */