//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1004.0.0.0.0
//
#ifndef DAMailboxDeleteMessageRequest_h
#define DAMailboxDeleteMessageRequest_h
@import Foundation;

#include "DAMailboxRequest.h"

@interface DAMailboxDeleteMessageRequest : DAMailboxRequest
/* instance methods */
- (id)initRequestWithMessageID:(id)id;
- (unsigned long long)hash;
- (BOOL)isEqual:(id)equal;
- (id)description;
@end

#endif /* DAMailboxDeleteMessageRequest_h */