//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tools: [ld (607.2), ld (814.1), ld (902.8)]
//    - LC_SOURCE_VERSION: 7.2.10.0.0
//
#ifndef AMSHTTPArchiveTaskInfo_h
#define AMSHTTPArchiveTaskInfo_h
@import Foundation;

#include "NSSecureCoding-Protocol.h"

@class NSData, NSURLSessionTaskMetrics;

@interface AMSHTTPArchiveTaskInfo : NSObject<NSSecureCoding>

@property (readonly, nonatomic) NSURLSessionTaskMetrics *metrics;
@property (readonly, nonatomic) NSData *HTTPBody;
@property (readonly, nonatomic) NSData *responseData;

/* class methods */
+ (BOOL)supportsSecureCoding;

/* instance methods */
- (id)initWithURLTaskInfo:(id)info;
- (void)encodeWithCoder:(id)coder;
- (id)initWithCoder:(id)coder;
@end

#endif /* AMSHTTPArchiveTaskInfo_h */