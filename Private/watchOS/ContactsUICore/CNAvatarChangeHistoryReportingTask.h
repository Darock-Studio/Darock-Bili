//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3505.0.0.0.0
//
#ifndef CNAvatarChangeHistoryReportingTask_h
#define CNAvatarChangeHistoryReportingTask_h
@import Foundation;

#include "CNTask.h"
#include "CNAvatarCacheChangeListenerDelegate-Protocol.h"

@class NSArray;

@interface CNAvatarChangeHistoryReportingTask : CNTask

@property (readonly, copy, nonatomic) NSArray *identifiers;
@property (readonly, nonatomic) NSObject<CNAvatarCacheChangeListenerDelegate> *delegate;

/* instance methods */
- (id)initWithIdentifiers:(id)identifiers delegate:(id)delegate;
- (id)run:(id *)run;
@end

#endif /* CNAvatarChangeHistoryReportingTask_h */