//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 252.9.0.0.0
//
#ifndef FTMutableBatchRecoverFinalResponse_h
#define FTMutableBatchRecoverFinalResponse_h
@import Foundation;

#include "FTBatchRecoverFinalResponse.h"

@class NSString;

@interface FTMutableBatchRecoverFinalResponse : FTBatchRecoverFinalResponse

@property (copy, nonatomic) NSString *speech_id;
@property (copy, nonatomic) NSString *session_id;
@property (nonatomic) int error_code;
@property (copy, nonatomic) NSString *error_str;
@property (nonatomic) int num_of_requested;
@property (nonatomic) int num_of_processed;
@property (nonatomic) int num_of_succeeded;

/* instance methods */
- (id)init;
- (id)copyWithZone:(struct _NSZone *)zone;
@end

#endif /* FTMutableBatchRecoverFinalResponse_h */