//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 252.9.0.0.0
//
#ifndef _LTBatchTextTranslationRequest_h
#define _LTBatchTextTranslationRequest_h
@import Foundation;

#include "_LTTranslationRequest.h"

@class NSArray;

@interface _LTBatchTextTranslationRequest : _LTTranslationRequest

@property (copy, nonatomic) NSArray *paragraphs;
@property (copy, nonatomic) id /* block */ textHandler;
@property (copy, nonatomic) id /* block */ translationHandler;

/* instance methods */
- (id)loggingType;
- (void)_startTranslationWithService:(id)service done:(id /* block */)done;
- (void)_translationFailedWithError:(id)error;
@end

#endif /* _LTBatchTextTranslationRequest_h */