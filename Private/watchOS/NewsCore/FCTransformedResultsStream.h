//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 617.0.0.0.0
//
#ifndef FCTransformedResultsStream_h
#define FCTransformedResultsStream_h
@import Foundation;

#include "FCStreaming-Protocol.h"

@class NSString;

@interface FCTransformedResultsStream : NSObject<FCStreaming>

@property (retain, nonatomic) NSObject<FCStreaming> *stream;
@property (copy, nonatomic) id /* block */ asyncTransformBlock;
@property (readonly, nonatomic) BOOL finished;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (id)initWithStream:(id)stream asyncTransformBlock:(id /* block */)block;
- (id)fetchMoreResultsWithLimit:(unsigned long long)limit qualityOfService:(long long)service callbackQueue:(id)queue completionHandler:(id /* block */)handler;
- (BOOL)isFinished;
@end

#endif /* FCTransformedResultsStream_h */