//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1235.0.0.0.0
//
#ifndef _CNDataDetectorsHandleStringClassificationStrategy_h
#define _CNDataDetectorsHandleStringClassificationStrategy_h
@import Foundation;

#include "_CNHandleStringClassificationStrategy-Protocol.h"

@class NSString;

@interface _CNDataDetectorsHandleStringClassificationStrategy : NSObject<_CNHandleStringClassificationStrategy>

@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)dataDetectorsStrategy;
+ (id)assistedDataDetectorsStrategy;

/* instance methods */
- (unsigned long long)classificationOfHandleString:(id)string;
@end

#endif /* _CNDataDetectorsHandleStringClassificationStrategy_h */