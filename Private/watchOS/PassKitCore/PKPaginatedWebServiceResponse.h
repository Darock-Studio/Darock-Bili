//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1552.3.6.1.1
//
#ifndef PKPaginatedWebServiceResponse_h
#define PKPaginatedWebServiceResponse_h
@import Foundation;

#include "PKWebServiceResponse.h"

@class NSArray, NSDate;

@interface PKPaginatedWebServiceResponse : PKWebServiceResponse

@property (readonly, nonatomic) NSArray *rawDataList;
@property (readonly, nonatomic) BOOL moreComing;
@property (readonly, nonatomic) NSDate *lastUpdated;

/* class methods */
+ (id)responseWithData:(id)data;
+ (BOOL)supportsSecureCoding;

/* instance methods */
- (id)initWithData:(id)data;
- (id)debugDescription;
- (id)initWithCoder:(id)coder;
- (void)encodeWithCoder:(id)coder;
@end

#endif /* PKPaginatedWebServiceResponse_h */