//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1552.3.6.1.1
//
#ifndef PKDiscoveryArticleLayoutResponse_h
#define PKDiscoveryArticleLayoutResponse_h
@import Foundation;

#include "PKDiscoveryWebServiceResponse.h"
#include "PKDiscoveryArticleLayout.h"

@interface PKDiscoveryArticleLayoutResponse : PKDiscoveryWebServiceResponse

@property (readonly, nonatomic) PKDiscoveryArticleLayout *discoveryArticleLayout;

/* instance methods */
- (id)initWithData:(id)data;
@end

#endif /* PKDiscoveryArticleLayoutResponse_h */